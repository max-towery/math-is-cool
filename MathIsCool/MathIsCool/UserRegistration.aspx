 <%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserRegistration.aspx.cs"%>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="row">
            <h2>Register</h2>
        </div>
        <div class="row">
            
            <div class="col-lg-5 col-md-5 col-sm-12 col-md-offset-1">
                <div class="form-group">

                    <label class="control-label" for="Username">Username</label>
                    <input id="Username" type="text" name="Username" class="form-control" />

                    <label for="FirstName" class="control-label">First Name</label>
                    <input id="FirstName" type="text" name="FirstName" class="form-control" />

                    <label for="LastName" class="control-label">Last Name</label>
                    <input id="LastName" type="text" name="LastName" class="form-control" />

                    <label for="Password" class="control-label">Password </label>
                    <input id="Password" type="password" name="Password" class="form-control" />

                    <label for="Email" class="control-label">Email </label>
                    <input id="Email" type="email" name="Email" class="form-control" />
                </div>
            </div>
            <div class="col-lg-5 col-md-5 col-sm-12 ">
                <div class="form-group">

                    <label for="Street" class="control-label">Street </label>
                    <input id="Street" type="text" name="Street" class="form-control" />

                    <label for="City" class="control-label">City </label>
                    <input id="City" type="text" name="City" class="form-control" />

                    <label for="State" class="control-label">State </label>
                    <input id="State" type="text" name="State" class="form-control" />

                    <label for="Zip" class="control-label">Zip </label>
                    <input id="Zip" type="text" name="Zip" class="form-control" />

                    <label for="Phone" class="control-label">Phone </label>
                    <input id="Phone" type="tel" name="Phone" class="form-control" />
                </div>
            </div>
        </div>
        <div class="row">
                <div class="col-md-12">
                    <button id="btnSubmit"  class="btn btn-primary text-center">Submit</button>

                </div>
        </div>
    </div>

    <script>
        $("#btnSubmit").on("click", function () {
            //var uri = "/api/Users"
            //var id = $('#Username').val();
            //var exists = false;
            //debugger;
            //$.ajax({
            //    url: uri + "?username=" + id,
            //    type: 'GET',
            //    dataType: 'json',
            //    success: function (data) {
            //        debugger;
            //        if (data.user_name === id){
            //            alert("The Username entered is already in use.")
            //        }
            //        else {
            //            createUser();
            //        }
                    
            //    },
            //    error: function (x, y, z) {
            //        alert("Error calling API: " + uri + " " + x + " " + y + " " + z);

            //    }
            //});
                        
            createUser();

            function createUser(){
                var addressApiUrl = "/api/Addresses";
                var addressGUID = guid();
                var userAddress = {
                    address_id: addressGUID,
                    perm_id: "7b8a2626-f190-410d-935c-0f2396c5a069",
                    street: $("#Street").val(),
                    city: $("#City").val(),
                    state: $("#State").val(),
                    zip: $("#Zip").val(),
                    phone: $("#Phone").val()
                };

                var address = JSON.stringify(userAddress);



                $.ajax({
                    type: "POST",
                    url: addressApiUrl,
                    //datatype: "json",
                    data: address,
                    contentType: "application/json; charset=utf-8",
                    processData: true,
                    success: function (data, status, jqXHR) {
                        alert("Address entered into database");
                    },
                    error: function (xhr, data) {
                        alert("Failed to enter address into DB " + data);
                    }
                });

                var userApiUrl = "/api/Users";
                var userGUID = guid();
                var userDTO = {
                    user_id: userGUID,
                    perm_id: "4ca4e274-7028-4d0a-b424-0899d376eaea",
                    address_id: addressGUID,
                    user_name: $("#Username").val(),
                    passkey: $("#Password").val(),
                    email: $("#Email").val(),
                    fname: $("#FirstName").val(),
                    lname: $("#LastName").val()
                };

                var user = JSON.stringify(userDTO);



                $.ajax({
                    type: "POST",
                    url: userApiUrl,
                    //datatype: "json",
                    data: user,
                    contentType: "application/json; charset=utf-8",
                    processData: true,
                    
                    success: function (data, status, jqXHR) {
                        alert("Added " + $("#Username").val() + " to the DB");
                    },
                    error: function (xhr, data) {
                        alert("Failed to add " + $("#Username").val() + " to DB " + data);
                    }
                });
            }
            
        });

        function guid() {
            function s4() {
                return Math.floor((1 + Math.random()) * 0x10000)
                  .toString(16)
                  .substring(1);
            }
            return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
              s4() + '-' + s4() + s4() + s4();
        }
    </script>
</asp:Content>
