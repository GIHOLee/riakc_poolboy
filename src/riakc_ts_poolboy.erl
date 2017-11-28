-module(riakc_ts_poolboy).

-export([
	 'query'/2, 'query'/3, 'query'/4, 'query'/5,
	 get_coverage/3, 
	 replace_coverage/4, replace_coverage/5,
	 put/3, put/4,
	 get/4,
	 delete/4,
	 stream_list_keys/2, stream_list_keys/3	 
	]).

-define(RIAKC_MODULE, riakc_ts).

'query'(PoolName, Query) ->
    'query'(PoolName, Query, [], undefined, []).

'query'(PoolName, Query, Interpolations) ->
    'query'(PoolName, Query, Interpolations, undefined, []).

'query'(PoolName, Query, Interpolations,  Cover) ->
    'query'(PoolName, Query, Interpolations, Cover, []).

'query'(PoolName, Query, Interpolations, Cover, Options) ->
    riakc_poolboy:exec(PoolName, add_apply(?RIAKC_MODULE, query, [Query, Interpolations, Cover, Options])).

get_coverage(PoolName, Tabel, Query) ->
    riakc_poolboy:exec(PoolName, add_apply(?RIAKC_MODULE, get_coverage, [Tabel, Query])).

replace_coverage(PoolName, Tabel, Query, Cover) ->
    replace_coverage(PoolName, Tabel, Query, Cover, []).

replace_coverage(PoolName, Tabel, Query, Cover, Other) ->
    riakc_poolboy:exec(PoolName, add_apply(?RIAKC_MODULE, replace_coverage, [Tabel, Query, Cover, Other])).

put(PoolName, Tabel, Measurements) ->
    put(PoolName, Tabel, Measurements, []).

put(PoolName, Tabel, Measurements, Options) ->
    riakc_poolboy:exec(PoolName, add_apply(?RIAKC_MODULE, put, [Tabel, Measurements, Options])).

get(PoolName, Tabel, Key, Options) ->
    riakc_poolboy:exec(PoolName, add_apply(?RIAKC_MODULE, get, [Tabel, Key, Options])).

delete(PoolName, Tabel, Key, Options) ->
    riakc_poolboy:exec(PoolName, add_apply(?RIAKC_MODULE, delete, [Tabel, Key, Options])).

stream_list_keys(PoolName, Tabel) ->
    stream_list_keys(PoolName, Tabel, infinity).

stream_list_keys(PoolName, Tabel, Options) ->
    riakc_poolboy:exec(PoolName, add_apply(?RIAKC_MODULE,  stream_list_keys, [Tabel, Options])).
    
add_apply(Mod, Fun, Args) ->
    {apply, Mod, Fun, Args}.

