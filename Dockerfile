FROM openjdk:17-alpine

RUN addgroup -g 1000 tmpusrgp
RUN adduser -u 1000 -G tmpusrgp -h /home/tmpusr -D tmpusr
USER tmpusr
RUN mkdir -p /home/tmpusr/app
WORKDIR /home/tmpusr/app

COPY --chown=tmpusr:tmpusrgp target/*.jar .

EXPOSE 8000
ENTRYPOINT [ "java" ]
CMD [ "-jar", "demo-0.0.1.jar", "--server.address=0.0.0.0", "--server.port=8000" ]

HEALTHCHECK --interval=30s --timeout=30s --retries=3 \
    CMD curl -f http://localhost:8000/api/actuator/health || exit 1