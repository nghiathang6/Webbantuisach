<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dangky.aspx.cs" Inherits="Baitaplonltw.Dangky" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dangky</title>
    <link href="StyleSheet1.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container" runat="server">

            <h2 style="text-align:center;">Đăng ký</h2>

            <p style="font-weight:bold">Nhập họ và tên:</p>
            <div class="input-container">
                <asp:TextBox ID="txtHoTen" runat="server" placeholder="Nhập tên của bạn"></asp:TextBox>
            </div>
            <p id="name-error" class="error-message"><asp:Literal ID="litNameError" runat="server" /></p>

            <p style="font-weight:bold">Nhập E-mail:</p>
            <div class="input-container">
                <asp:TextBox ID="txtEmailDangKy" runat="server" placeholder="Nhập Email"></asp:TextBox>
            </div>
            <p id="email-error" class="error-message"><asp:Literal ID="litEmailError" runat="server" /></p>

            <p style="font-weight:bold">Nhập mật khẩu:</p>
            <div class="input-container">
                <asp:TextBox ID="txtMatKhauDangKy" runat="server" placeholder="Nhập mật khẩu" ></asp:TextBox>
            </div>
            <p id="matkhau-error" class="error-message"><asp:Literal ID="litMatKhauError" runat="server" /></p>

            <p style="font-weight:bold">Nhập lại mật khẩu:</p>
            <div class="input-container">
                <asp:TextBox ID="txtNhapLaiMatKhau" runat="server" placeholder="Nhập lại mật khẩu" ></asp:TextBox>
            </div>
            <p id="nhaplaimatkhau-error" class="error-message"><asp:Literal ID="litNhapLaiMatKhauError" runat="server" /></p>

            

            <div style="display: flex; gap: 10px;">
                <asp:Button ID="btnNhapLai" runat="server" Text="Nhập lại" OnClick="btnNhapLai_Click" CssClass="btn-reset" />
                <asp:Button  ID="btnDangKy" 
                    runat="server" 
                    Text="Đăng ký" 
                    OnClick="btnDangKy_Click" 
                    CssClass="btn-dangky"  
                    OnClientClick="return validateForm();" />
            </div>

            <a href="Dangnhap.aspx" class="have">Bạn đã có tài khoản? Đăng nhập</a>

        </div>
    </form>
   

</body>
</html>
