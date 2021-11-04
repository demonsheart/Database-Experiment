// myAlert("#liveAlertPlaceholder", errMsg.responseText, "warning")
function myAlert(selector, message, type) {
    let wrapper = document.createElement('div')
    wrapper.innerHTML = '<div class="alert alert-' + type + ' alert-dismissible" role="alert">' + message + '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>'

    $(selector).append(wrapper)
}

//  let json = arrayToJson($(this).serializeArray())
function arrayToJson(array) {
    let data = {}
    $.each(array, function (index, item) {
        // TODO: need to fix string -> int
        data[item.name] = item.value
    })
    let jsonStr = JSON.stringify(data)
    return jsonStr
}

// deleteData("http://localhost:8080/tables/customers/delete", "cid", $(this).attr("data-key"))
function deleteData(url, key, value, valueType) {
    let jsonStr  = '{"'+ key +'":"'+ value +'"}'
    if (valueType === "number") {
        jsonStr  = '{"'+ key +'":'+ value +'}'
    }
    console.log(jsonStr)
    $.ajax({
        type: "POST",
        url: url,
        data: jsonStr,
        contentType: "application/json; charset=utf-8",
        success: function(data){
            console.log(data)
            window.location.reload()
        },
        error: function(errMsg) {
            console.log(errMsg)
        }
    })
}

function modifyData(url, jsonStr) {
    $.ajax({
        type: "POST",
        url: url,
        data: jsonStr,
        contentType: "application/json; charset=utf-8",
        success: function(data){
            myAlert("#alertPlaceholder", "Modify successfully!", "success")
        },
        error: function(errMsg) {
            myAlert("#alertPlaceholder", errMsg.responseText, "warning")
            setTimeout((() => window.location.reload()), 2000)
        }
    })
}


function createInputField(key, type) {
    return '<div class="row mb-3">' +
        '<label for="'+ key +'" class="col-sm-2 col-form-label">'+ key +'</label>' +
        '<div class="col-sm-10">' +
        '<input type="'+ type +'" step="any" class="form-control" id="'+ key +'" name="'+ key +'" required></div></div>'
}