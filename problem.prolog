program(
    [
        argument(int, source_account),
        argument(int, destination_account),
        argument(int, amount)
    ], [
        change(source_account, amount),
        change(destination_account, amount) 
    ]).


interception_between(
    program([argument(_, ARGUMENT_VALUE)|ARGUMENT_LIST], 
                [change(ARGUMENT_VALUE, _)|BODY_LIST]
            )
        , FACTS, NEW_FACTS2) :- 
    print("Found fact, calling recursively\n"),
    append(FACTS, [problem(change(ARGUMENT_VALUE))], NEW_FACTS1),

    interception_between(
        program(
                    ARGUMENT_LIST, 
                    BODY_LIST
                )
            , NEW_FACTS1, NEW_FACTS2).

interception_between(
    program( [], []), _, _).

interception_between(
    program( _, []), [], _).

interception_between(
    program( [], _), [], _).

interception_between(
    program( _, _), [], _).
