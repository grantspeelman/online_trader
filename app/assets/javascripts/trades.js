$(function () {
    $("#trade_trade_with").autocomplete({
        source:"/users/search.json",
        minLength:2
    });
    $(".trade_card").autocomplete({
        source:"/cards/search.json",
        minLength:2
    });
});
