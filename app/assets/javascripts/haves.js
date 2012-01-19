$(function () {
    $("#have_card_name").autocomplete({
        source:"/cards/search.json",
        minLength:2
    });
});