FROM ubuntu

RUN apt-get update && apt-get install -y apt-transport-https
RUN apt-get install -y curl
RUN curl --silent --location https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
RUN apt-get install -y build-essential

RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz
RUN mkdir -p /usr/local/gcloud
RUN tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz
RUN /usr/local/gcloud/google-cloud-sdk/install.sh
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

RUN npm install -g @google-cloud/functions-emulator
RUN npm install request fs ffmpeg-stream @google-cloud/storage child_process

RUN apt-get update && apt-get install -y bash
RUN apt-get install -y apt-transport-https

RUN apt-get update
RUN apt-get install -y ffmpeg
WORKDIR /functions

COPY src/index.js .
COPY src/package.json .
COPY src/start.sh .
COPY src/test01.flac .

ENTRYPOINT [ "bash", "start.sh" ]
