FROM node
WORKDIR /functions

RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz
RUN mkdir -p /usr/local/gcloud
RUN tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz
RUN /usr/local/gcloud/google-cloud-sdk/install.sh
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

RUN npm install -g @google-cloud/functions-emulator

COPY src/index.js .
COPY src/package.json .
COPY src/start.sh .
RUN npm install request

ENTRYPOINT [ "bash", "start.sh" ]
