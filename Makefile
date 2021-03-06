.PHONY: deps test doc

REBAR3=./rebar3

all: deps compile

compile:
	$(REBAR3) compile

deps:
	$(REBAR3) get-deps

clean:
	$(REBAR3) clean

distclean: clean 
	$(REBAR3) delete-deps

test: 
	$(REBAR3) skip_deps=true ct

dialyzer: compile
	@dialyzer -Wno_undefined_callbacks \
        -r ebin \
        -r deps/folsom \
        -r deps/poolboy \
        -r deps/riakc
