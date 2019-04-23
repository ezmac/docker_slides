################################################################################
# catimg script by Eduardo San Martin Morote aka Posva                         #
# http://posva.net                                                             #
#                                                                              #
# Ouput the content of an image to the stdout using the 256 colors of the      #
# terminal.                                                                    #
# Github: https://github.com/posva/catimg                                      #
################################################################################

function help() {
  echo "Usage catimg [-h] [-w width] [-c char] img text text"
  echo "By default char is \"  \" and w is the terminal width"
}

# VARIABLES
COLOR_FILE=$(dirname $0)/colors.png
CHAR="  "

WIDTH=""
IMG=""
TEXT=()

while getopts qw:c:h opt; do
  case "$opt" in
    w) WIDTH="$OPTARG" ;;
    c) CHAR="$OPTARG" ;;
    h) help; exit ;;
    *) help ; exit 2;;
    esac
  done

if [ "$1" ]; then
  IMG="$1"
  shift
fi
while [ "$1" ]; do
  TEXT+=("$1")
  shift
done

if [ "$IMG" = "" -o ! -f "$IMG" ]; then
  help
  exit 1
fi

if [ ! "$WIDTH" ]; then
  COLS=$(expr $(tput cols) "/" $(echo -n "$CHAR" | wc -c))
else
  COLS=$(expr $WIDTH "/" $(echo -n "$CHAR" | wc -c))
fi
WIDTH=$(convert "$IMG" -print "%w\n" /dev/null)
if [ "$WIDTH" -gt "$COLS" ]; then
  WIDTH=$COLS
fi

REMAP=""
if convert "$IMG" -resize $COLS\> +dither -remap $COLOR_FILE /dev/null ; then
  REMAP="-remap $COLOR_FILE"
else
  echo "The version of convert is too old, don't expect good results :(" >&2
  #convert "$IMG" -colors 256 PNG8:tmp.png
  #IMG="tmp.png"
fi

# Display the image
I=0
IMGTEXT=$(convert "$IMG" -resize $COLS\> +dither `echo $REMAP` txt:- 2>/dev/null |
  sed -e 's/.*none.*/NO NO NO/g' -e '1d;s/^.*(\(.*\)[,)].*$/\1/g;y/,/ /' )

rows=$((((${#IMGTEXT}/$WIDTH)) /10))
echo $rows

line=0
centerRow=$((($rows+1)/2))
centerCol=$(($WIDTH - ${#TEXT[0]}))
toff=0
echo ${TEXT[0]}
tlen=$(( ${#TEXT[0]}/2 ))
tstart=$(( ($WIDTH/2) - (${#TEXT[0]}/2) ))
tend=$(( ($WIDTH/2) + (${#TEXT[0]}/2) ))
echo $tstart $tend $tlen

echo $IMGTEXT|
while read R G B f; do
  if [ ! "$R" = "NO" ]; then
    if [ "$R" -eq "$G" -a "$G" -eq "$B" ]; then
      ((
      I++,
      IDX = 232 + R * 23 / 255
      ))
    else
      ((
      I++,
      IDX = 16
      + R * 5 / 255 * 36
      + G * 5 / 255 * 6
      + B * 5 / 255
      ))
    fi
    if [ "$line" -eq "$centerRow" ]; then
      #echo -ne "\e[48;5;${IDX}m${TEXT[0][$toff]}"
      POS=$(( $I%$WIDTH ))
      if [  "$POS" -ge "$tstart"  -a "$POS" -lt "$tend"  ]; then
        echo -ne "\e[48;5;${IDX}mA"
      else
        echo -ne "\e[48;5;${IDX}m${CHAR}"
      fi
    else
      echo -ne "\e[48;5;${IDX}m${CHAR}"
    fi
    #echo "$R,$G,$B: $IDX"
  else
    (( I++ ))
    echo -ne "\e[0m${CHAR}"
  fi
  # New lines
  (( $I % $WIDTH )) ||   echo -e "\e[0m" || ((line++))
  (( $I % $WIDTH )) || ((line++))
done
echo $rows $COLS
echo $centerRow $line
