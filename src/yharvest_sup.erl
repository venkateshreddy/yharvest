
-module(yharvest_sup).

-behaviour(supervisor).

-author("venkateshk@ybrantdigital.com").
%% API
-export([start_link/0, stop/0]).

%% Supervisor callbacks
-export([init/1,start_process/0]).
-include("include/defines.hrl").


%% ===================================================================
%% API functions
%% ===================================================================
%% @doc start the main supervisor
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

%% @doc Init Callback. Initialize the main supervisor.
%% Check for the number of channels on Rabbit
%% Check if all the standard queues for Pangea exist, if not start them all
%% Spawn a supervisor for each queue.

%% @todo Implement Logging - lager or log4erl
init([]) ->
	start_process()
.

start_process() ->
	{ok,Pid} = yharvest_schedular:start_link(),
	io:format("pid is : ~p ~n",[Pid]),
	timer:sleep(15000),
	exit(Pid,kill),
	io:format("this is after sleep",[]),
	start_process()
.
%% @doc API call to stop the supervisor
stop() ->
    exit(whereis(?MODULE), shutdown)
.