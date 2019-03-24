FROM swift:4.2
COPY . /FitDataProtocol
WORKDIR /FitDataProtocol
RUN swift build
