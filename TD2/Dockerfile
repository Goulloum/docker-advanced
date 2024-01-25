FROM debian:latest
RUN apt-get clean && apt-get update && apt-get install python3-pip -y && pip3 install flask==2.0.3
COPY server.py /my_server/server.py
WORKDIR /my_server
EXPOSE 5000
CMD ["python3", "server.py"]