﻿<%@ Page Title="Add Admin Members" Language="C#" MasterPageFile="~/Admin-Dashboard.Master" AutoEventWireup="true" CodeBehind="Add-Admin-Members.aspx.cs" Inherits="Z_Wallet.Add_Admin_Members" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="dashboard-wrapper">
            <div class="container-fluid dashboard-content">
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                        <div class="page-header">
                            <h2 class="pageheader-title"><i class="fa fa-fw fa-user"></i>Add Admin Members </h2>
                            <div class="page-breadcrumb">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/Admin" class="breadcrumb-link">Dashboard</a></li>
                                        <li class="breadcrumb-item"><a href="/Add-Admin-Members" class="breadcrumb-link">Admin Admin Members</a></li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="mb-0">Profile Picture</h4>
                            </div>
                            <div class="card-body text-center">
                                <div class="rounded-circle overflow-hidden profile-picture">
                                    <asp:Image ID="previewImage" runat="server" CssClass="img-fluid" Style="max-width: 100%; height: auto;" ImageUrl="~/Content/assets/images/user.png" />
                                </div>
                                <br />
                                <div class="d-flex justify-content-center">
                                    <div class="w-75">
                                        <asp:FileUpload ID="fileUpload" runat="server" CssClass="mb-3" Style="display: none;" onchange="previewFile()" />
                                    </div>
                                </div>
                                <asp:Button ID="btnChooseFile" runat="server" Text="Choose File" CssClass="btn btn-secondary mt-3 mr-1" OnClientClick="chooseFile();return false;" />
                                <asp:RegularExpressionValidator ID="revImageFile" runat="server" ControlToValidate="fileUpload" ErrorMessage="<br />Invalid file format. Please choose an image." ValidationExpression="^.*\.(jpg|JPG|jpeg|JPEG|png|PNG)$" CssClass="text-danger"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="mb-0">Admin Profile Information</h4>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="firstName">First name</label>
                                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="lastName">Last name</label>
                                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                    </div>
                                    <div class="col-md-12 mb-3">
                                        <label for="email">Email</label>
                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="Password">Password</label>
                                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder=""></asp:TextBox>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="confirmPassword">Confirm Password</label>
                                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder=""></asp:TextBox>
                                        <asp:CompareValidator ID="cvPasswordMatch" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" ErrorMessage="Passwords do not match." CssClass="text-danger"></asp:CompareValidator>
                                    </div>
                                </div>
                                <div class="form-group row text-right">
                                    <div class="col col-sm-10 col-lg-12 offset-lg-0">
                                        <asp:Button ID="btnCreate" runat="server" Text="Create" CssClass="btn btn-space btn-primary" OnClick="btnCreate_Click" />
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-space btn-secondary" OnClick="btnCancel_Click" />
                                    </div>
                                </div>
                                <div class="form-group row text-center">
                                    <div class="col-lg-12">
                                        <asp:Label ID="lblSuccessMessage" runat="server" CssClass="text-success font-16" Visible="false"></asp:Label>
                                        <asp:Label ID="lblErrorMessage" runat="server" CssClass="text-danger font-16" Visible="false"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <style>
        .profile-picture {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            overflow: hidden;
            margin: 0 auto;
        }

        .profile-picture img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .custom-file-input {
            position: relative;
            overflow: hidden;
            margin-top: 8px;
        }

        .custom-file-label {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            padding: 0.375rem 0.75rem;
            line-height: 1.5;
            color: #495057;
            background-color: #fff;
            border: 1px solid #ced4da;
            border-radius: 0.25rem;
            transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
            cursor: pointer;
        }

        .custom-file-input:focus ~ .custom-file-label {
            border-color: #80bdff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }
    </style>

    <script>
        function chooseFile() {
            var fileInput = document.getElementById('<%=fileUpload.ClientID%>');
            fileInput.click();
        }

        function previewFile() {
            var preview = document.getElementById('<%=previewImage.ClientID%>');
            var fileInput = document.getElementById('<%=fileUpload.ClientID%>');
            var file = fileInput.files[0];
            var reader = new FileReader();

            reader.onloadend = function () {
                preview.src = reader.result;
                preview.style.display = "block";
            };

            if (file) {
                reader.readAsDataURL(file);
            } else {
                preview.src = "";
                preview.style.display = "none";
            }
        }
    </script>
</asp:Content>