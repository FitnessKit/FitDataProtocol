FROM swift:5.0
COPY . /FitDataProtocol
WORKDIR /FitDataProtocol
RUN swift build
