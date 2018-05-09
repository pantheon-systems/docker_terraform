FROM golang:1.9

WORKDIR /go/src/github.com/terraform-providers
RUN git clone --branch v0.1.4 https://github.com/terraform-providers/terraform-provider-fastly.git

WORKDIR /go/src/github.com/terraform-providers/terraform-provider-fastly
RUN CGO_ENABLED=0 go build -ldflags="-s -w"


FROM hashicorp/terraform:0.10.2
COPY --from=0 /go/src/github.com/terraform-providers/terraform-provider-fastly/terraform-provider-fastly /bin/terraform-provider-fastly

ADD terraformrc /root/.terraformrc

RUN mkdir /tf

WORKDIR /tf
