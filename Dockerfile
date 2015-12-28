FROM ruby:2.2

# Install curl
# RUN apt-get update && apt-get install -y curl && apt-get clean && rm -rf /var/lib/apt/lists

# RUN gem install passenger
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7 \
	&& apt-get update \
	&& apt-get install -y apt-transport-https ca-certificates \
	&& sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger jessie main > /etc/apt/sources.list.d/passenger.list' \
	&& apt-get update \
	&& apt-get install -y passenger \
	&& apt-get clean \
	&& rm -rf /var/lib/opt/lists

RUN echo Built on 28-12-2015
RUN curl -o dist.tar.gz http://lafo.ssw.uni-linz.ac.at/graalvm/jruby-dist-master+graal-linux-x86_64-bin.tar.gz \
	&& tar -zxf dist.tar.gz \
	&& jruby-master/bin/jruby -X+T -e 'puts "Runnnig on Graal?: #{Truffle.graal?}"' \
	&& rm dist.tar.gz

RUN echo 'exec /jruby-master/bin/jruby -X+T "$@"' > /jruby-master/bin/ruby && chmod +x /jruby-master/bin/ruby
# ENV PATH "/jruby-master/bin:$PATH"

CMD cd /app;passenger start --ruby /jruby-master/bin/ruby
