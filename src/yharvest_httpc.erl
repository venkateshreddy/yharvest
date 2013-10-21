-module(yharvest_httpc).

-author("venkateshk@ybrantdigital.com").

-include("include/defines.hrl").
-export([get_country_stats/1]).

get_country_stats({Query, Country}) ->               
    {ok, "200", _, Response} = ibrowse:send_req(Query, [],get, [], [{is_ssl, true}, {ssl_options, []}],150000),
    ObjList = mochijson2:decode(Response),
    BodyList = [Body || {struct, [_,_,Body]} <- ObjList ],
    ProJson = [Json || {<<"body">>, Json} <- BodyList],
    DecodedJson = [mochijson2:decode(X) || X <- ProJson],
    StructData = [proplists:get_value(<<"data">>,InnerObj) || {struct, InnerObj} <- DecodedJson],
    [AllGenders, Male, Female] = [lists:sublist(StructData, 1, 8), lists:sublist(StructData,9, 8), lists:sublist(StructData, 17, 8)],
    [A0, A1, A2, A3, A4, A5, A6, A7] = AllGenders,
    [M0, M1, M2, M3, M4, M5, M6, M7] = Male,
    [F0, F1, F2, F3, F4, F5, F6, F7] = Female,
    Avalue = {struct, [{"all", A0},{"a_13_17", A1},{"a_18_24",A2},{"a_25_34",A3},{"a_35_44",A4}, {"a_45_54",A5}, {"a_55_64",A6}, {"a_65", A7}]},
    Mvalue = {struct, [{"all", M0},{"a_13_17", M1},{"a_18_24",M2},{"a_25_34",M3},{"a_35_44",M4}, {"a_45_54",M5}, {"a_55_64",M6}, {"a_65", M7}]},
    Fvalue = {struct, [{"all", F0},{"a_13_17", F1},{"a_18_24",F2},{"a_25_34",F3},{"a_35_44",F4}, {"a_45_54",F5}, {"a_55_64",F6}, {"a_65", F7}]},
    GenderObject = iolist_to_binary(mochijson2:encode({struct, [{"All", Avalue },{"Male",Mvalue},{"Female",Fvalue}]})),
    GenderObject
.