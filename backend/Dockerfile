FROM node:20.15.0-alpine3.20
EXPOSE 8080
ENV DB_HOST=mysql
# addgroup -S expense creates a system group named expense.
# adduser -S expense -G expense creates a system user named expense and adds this user to the expense group.
RUN addgroup -S expense && adduser -S expense -G expense \
    && mkdir /opt/server \
    && chown expense:expense -R /opt/server
WORKDIR /opt/server
COPY package.json .
COPY *.js /opt/server/
RUN npm install
USER expense
EXPOSE 8081
CMD [ "node","index.js" ]