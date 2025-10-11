ARG BUILD_FROM=python:3.12-slim
FROM $BUILD_FROM
WORKDIR /app
RUN pip install --no-cache-dir libretranslate argostranslate
COPY run.sh /run.sh
RUN chmod +x /run.sh
EXPOSE 5000
CMD ["/run.sh"]