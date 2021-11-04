// myAlert("#liveAlertPlaceholder", errMsg.responseText, "warning")
function myAlert(selector, message, type) {
    let wrapper = document.createElement('div')
    wrapper.innerHTML = '<div class="alert alert-' + type + ' alert-dismissible" role="alert">' + message + '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>'

    $(selector).append(wrapper)
}

//  let json = arrayToJson($(this).serializeArray());
function arrayToJson(array) {
    let data = {};
    $.each(array, function (index, item) {
        data[item.name] = item.value;
    });
    let json = JSON.stringify(data);
    return json
}

// deleteData("http://localhost:8080/tables/customers/delete", "cid", $(this).attr("data-key"))
function deleteData(url, key, value) {
    let json  = '{"'+ key +'":"'+ value +'"}'
    $.ajax({
        type: "POST",
        url: url,
        // The key needs to match your method's input parameter (case-sensitive).
        data: json,
        contentType: "application/json; charset=utf-8",
        success: function(data){
            console.log(data)
            window.location.reload()
        },
        error: function(errMsg) {
            console.log(errMsg)
        }
    });
}