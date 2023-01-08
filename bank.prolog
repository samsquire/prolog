program([
    function(withdraw, [
        argument(int, source_account),
        argument(int, destination_account),
        argument(int, amount)
    ], [
        change(source_account, amount),
        change(destination_account, amount) 
    ]
    )],
    [
        withdraw([0, 1, 100])
    ]).

interception_between(
    program([function(withdraw, ARGUMENTS, BODY
    )],
    MAIN),
    matched_program([function(withdraw, ARGUMENTS, BODY
    )], MAIN),
    [], []).

interception_between(
    program([function(withdraw, _, _
    )],
    _),
    matched_program([
            function(withdraw, 
                [argument(_, ARGUMENT_VALUE)|_], 
                [change(ARGUMENT_VALUE, _)|[]]
            )],
        _), FACTS, NEW_FACTS) :- 
    print("Found fact no more body"),
    NEW_FACTS=[problem(change(ARGUMENT_VALUE))|FACTS].


interception_between(
    program([function(withdraw, _, _
    )],
    _),
    matched_program([
            function(withdraw, 
                [argument(_, _)|[]], 
                []
            )],
        _), _, _).

interception_between(
    program([function(withdraw, _, _
    )],
    _),
    matched_program([
            function(withdraw, 
                [argument(_, ARGUMENT_VALUE)|ARGUMENT_LIST], 
                [change(ARGUMENT_VALUE, _)|BODY_LIST]
            )],
        _), FACTS, OUTPUT_FACTS) :- 
    print("Found fact, calling recursively"),
    NEW_FACTS=[problem(change(ARGUMENT_VALUE))|FACTS],

    interception_between(
        program([function(withdraw, _, _
        )],
        _),
        matched_program([
                function(withdraw, 
                    ARGUMENT_LIST, 
                    BODY_LIST
                )],
            _), NEW_FACTS, OUTPUT_FACTS).

interception_between(
    program([function(withdraw, _, _
    )],
    _),
    matched_program([
            function(withdraw, 
                [], 
                []
            )],
        _), [], []) :-
    print("Empty match").
