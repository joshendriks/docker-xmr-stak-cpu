FROM ubuntu:17.04
RUN apt-get update
RUN apt-get install -y libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev git
RUN git clone https://github.com/fireice-uk/xmr-stak-cpu.git
RUN cd xmr-stak-cpu \
 && sed -i 's/constexpr double fDevDonationLevel.*/constexpr double fDevDonationLevel = 0.0;/' donate-level.h \
 && cat donate-level.h\
 && cmake . \
 && make install \
 && cp bin/xmr-stak-cpu /usr/local/bin/
RUN cd xmr-stak-cpu \
 && cp config.txt /config.txt \
 && rm -r /xmr-stak-cpu
#RUN apt-get remove -y libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev git \
# && apt-get autoremove -y
ENTRYPOINT ["xmr-stak-cpu"]
CMD ["/config.txt"]