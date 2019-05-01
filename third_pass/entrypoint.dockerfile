FROM ubuntu:latest

RUN apt-get update && apt-get install -y python3 python3-pip
#ENTRYPOINT ["/bin/bash"]
ENTRYPOINT ["python3"]
CMD ["-c", "print('hello')"]
