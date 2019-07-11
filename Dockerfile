# Google Cloud SDK image for general purpose use

FROM alpine:3.10@sha256:6a92cd1fcdc8d8cdec60f33dda4db2cb1fcdcacf3410a8e05b3741f44a9b5998

RUN set -xe \
	&& addgroup -g 6006 -S gcs \
	&& adduser -D -u 6006 -S -h /home/gcs -s /sbin/nologin -G gcs gcs \
	&& apk add --no-cache --virtual .build-deps \
		curl \
	&& apk add --no-cache --virtual .cloudsdk-rundeps \
		docker \
		openssh-client \
		python \
	&& curl -fSL https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.tar.gz -o google-cloud-sdk.tar.gz \
	&& tar -xzf google-cloud-sdk.tar.gz \
	&& google-cloud-sdk/install.sh \
		--usage-reporting=false \
		--path-update=false \
		--bash-completion=false \
	&& google-cloud-sdk/bin/gcloud config set --installation component_manager/disable_update_check true \
	&& sed -i -- 's/\"disable_updater\": false/\"disable_updater\": true/g' /google-cloud-sdk/lib/googlecloudsdk/core/config.json \
	\
	&& echo 'echo -e "\
	\e[1mINSTRUCTIONS:\e[0m Run the gcloud tool as normal. Example:\n\
	\n	\e[93mgcloud help\e[0m\n\
	"' > /home/gcs/instructions.sh \
	&& chmod +x /home/gcs/instructions.sh \
	\
	&& rm -f google-cloud-sdk.tar.gz \
	&& apk del .build-deps \
	\
	# Unset SUID on all files
	&& for i in $(find / -perm /6000 -type f); do chmod a-s $i; done

ENV PATH /google-cloud-sdk/bin:$PATH
WORKDIR /home/gcs
# USER gcs

CMD ["/bin/sh", "-sc", "/home/gcs/instructions.sh"]
