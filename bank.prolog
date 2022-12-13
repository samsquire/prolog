program([
    function(withdraw, [
        argument(int, source_account),
        argument(int, destination_account),
        argument(int, amount)
    ], [
        change(source_account, amount) 
    ]
    )],
    [
        withdraw([0, 1, 100])
    ]).

interception_between(
    program([function(withdraw, [
        argument(int, source_account),
        argument(int, destination_account),
        argument(int, amount)
    ], [
        change(source_account, amount) 
    ]
    )],
    [
        withdraw([0, 1, 100])
    ]),
    program([
            function(withdraw, 
                [], 
                []
            )],
        _), _, _).

interception_between(
    program([function(withdraw, [
        argument(int, source_account),
        argument(int, destination_account),
        argument(int, amount)
    ], [
        change(source_account, amount) 
    ]
    )],
    [
        withdraw([0, 1, 100])
    ]),
    program([
            function(withdraw, 
                _, 
                []
            )],
        _), _, _).

interception_between(
    program([function(withdraw, [
        argument(int, source_account),
        argument(int, destination_account),
        argument(int, amount)
    ], [
        change(source_account, amount) 
    ]
    )],
    [
        withdraw([0, 1, 100])
    ]),
    program([
            function(withdraw, 
                [], 
                _
            )],
        _), _, _).


interception_between(
    program([function(withdraw, ARGUMENTS, FUNCTION_ARGUMENTS
    )],
    PROGRAM_BODY),
    program([
            function(withdraw, 
                ARGUMENT_LIST, 
                FUNCTION_BODY_LIST
            )],
        _), FACTS, NEXT_FACTS) :- 

    interception_between(
    program([function(withdraw, ARGUMENTS, FUNCTION_ARGUMENTS
    )],
    PROGRAM_BODY),
        program([
                function(withdraw, 
                        ARGUMENT_LIST, 
                        FUNCTION_BODY_LIST
                )],
                _), FACTS, NEXT_FACTS).



interception_between(
    program([function(withdraw, ARGUMENTS, FUNCTION_ARGUMENTS
    )],
    PROGRAM_BODY),
    program([
            function(withdraw, 
                [argument(_, ARGUMENT_VALUE)|ARGUMENT_LIST], 
                [change(ARGUMENT_VALUE, _)|FUNCTION_BODY_LIST]
            )],
        _), FACTS, NEXT_FACTS) :- 

    append(FACTS, [problem(change(ARGUMENT_VALUE))], NEXT_FACTS),
    interception_between(
    program([function(withdraw, ARGUMENTS, FUNCTION_ARGUMENTS
    )],
    PROGRAM_BODY),
        program([
                function(withdraw, 
                        ARGUMENT_LIST, 
                        FUNCTION_BODY_LIST
                )],
                _), NEXT_FACTS).


