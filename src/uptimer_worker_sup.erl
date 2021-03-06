%%
%% Copyright (C) 2013 Björn-Egil Dahlberg
%%
%% File:    uptimer_worker_sup.erl
%% Author:  Björn-Egil Dahlberg
%% Created: 2013-07-12
%%

-module(uptimer_worker_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init(_) ->
    RestartStrategy = {simple_one_for_one, 5, 10},
    Children = [
	?CHILD(uptimer_worker, worker)
    ],
    {ok, {RestartStrategy, Children}}.
