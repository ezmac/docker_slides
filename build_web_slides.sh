#!/bin/bash


# For this slide deck, I use md as the extension.
# slides that got cut are .markdown.
# feel free to use them as reference

# don't judge me, I just wanted to make it run.
header=$(cat <<EOF
<section data-markdown>
  <textarea data-template>
EOF
)

footer=$(cat <<EOF
  </textarea>
</section>
EOF
)

for i in `ls ./*.md`; do
  slide_content=$(cat $i)
  slides="
  ${slides}
  ${header}
  ${slide_content}
  ${footer}
  "
done
html_start=$(cat <<EOF
<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

    <title>reveal.js</title>

    <link rel="stylesheet" href="reveal.js-3.8.0/css/reset.css">
    <link rel="stylesheet" href="reveal.js-3.8.0/css/reveal.css">
    <link rel="stylesheet" href="reveal.js-3.8.0/css/theme/solarized.css">
    <link rel="stylesheet" href="reveal-customize.css">

    <!-- Theme used for syntax highlighting of code -->
    <link rel="stylesheet" href="reveal.js-3.8.0/lib/css/monokai.css">

    <!-- Printing and PDF exports -->
    <script>
      var link = document.createElement( 'link' );
      link.rel = 'stylesheet';
      link.type = 'text/css';
      link.href = window.location.search.match( /print-pdf/gi ) ? 'reveal.js-3.8.0/css/print/pdf.css' : 'reveal.js-3.8.0/css/print/paper.css';
      document.getElementsByTagName( 'head' )[0].appendChild( link );
    </script>
  </head>
  <body>
    <div class="reveal">
      <div class="slides">
EOF
)
html_end=$(cat <<EOF
      </div>
    </div>

    <script src="reveal.js-3.8.0/js/reveal.js"></script>

    <script>
      // More info about config & dependencies:
      // - https://github.com/hakimel/reveal.js#configuration
      // - https://github.com/hakimel/reveal.js#dependencies
      Reveal.initialize({
	margin: 0,
	minScale: 1,
	maxScale: 1,
  width: 960,
  center: false,
  history: true,
  height: "100%",
        dependencies: [
          { src: 'reveal.js-3.8.0/plugin/markdown/marked.js' },
          { src: 'reveal.js-3.8.0/plugin/markdown/markdown.js' },
          { src: 'reveal.js-3.8.0/plugin/notes/notes.js', async: true },
          { src: 'reveal.js-3.8.0/plugin/highlight/highlight.js', async: true }
        ]
      });
    </script>
  </body>
</html>
EOF
)


echo "${html_start}
${slides}
${html_end}" > index.html
