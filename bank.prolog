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
    program([function(withdraw, _, _
    )],
    _),
    program([
            function(withdraw, 
                [argument(_, ARGUMENT_VALUE)|_], 
                [change(ARGUMENT_VALUE, _)|[]]
            )],
        _), FACTS, NEW_FACTS1) :- 
    print("Found fact no more body"),
    append(FACTS, [problem(change(ARGUMENT_VALUE))], NEW_FACTS1).



interception_between(
    program([function(withdraw, _, _
    )],
    _),
    program([
            function(withdraw, 
                [argument(_, ARGUMENT_VALUE)|ARGUMENT_LIST], 
                [change(ARGUMENT_VALUE, _)|BODY_LIST]
            )],
        _), FACTS, NEW_FACTS2) :- 
    print("Found fact, calling recursively"),
    append(FACTS, [problem(change(ARGUMENT_VALUE))], NEW_FACTS1),

    interception_between(
        program([function(withdraw, _, _
        )],
        _),
        program([
                function(withdraw, 
                    ARGUMENT_LIST, 
                    BODY_LIST
                )],
            _), NEW_FACTS1, NEW_FACTS2).

interception_between(
    program([function(withdraw, _, _
    )],
    _),
    program([
            function(withdraw, 
                [], 
                []
            )],
        _), [], _).

interception_between(
    program([function(withdraw, _, _
    )],
    _),
    program([
            function(withdraw, 
                _, 
                []
            )],
        _), [], _).

