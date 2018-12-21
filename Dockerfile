# Google Cloud SDK image for general purpose use

FROM alpine:3.8@sha256:46e71df1e5191ab8b8034c5189e325258ec44ea739bba1e5645cff83c9048ff1

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
