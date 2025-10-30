<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dangnhap.aspx.cs" Inherits="Baitaplonltw.Dangnhap" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dangnhap</title>
    <link href="StyleSheet1.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="form-container" runat="server">
         <h2 style="text-align:center;">Đăng nhập</h2>
        <p style="font-weight:bold">Nhập E-mail:</p>
        <div class="input-container">
            <asp:TextBox ID="txtEmailDangNhap" runat="server" placeholder="Nhập Email"></asp:TextBox>
        </div>

        <p style="font-weight:bold">Nhập mật khẩu:</p>
        <div class="input-container">
            <asp:TextBox ID="txtMatKhauDangNhap" runat="server" placeholder="Nhập mật khẩu"></asp:TextBox>
        </div>

        <p id="name-error" class="error-message">
            <asp:Literal ID="litDangNhapError" runat="server" />
        </p>

        <asp:Button ID="btnDangNhap" runat="server" Text="Đăng nhập" OnClick="btnDangNhap_Click" CssClass="btn-dangky" />

        <a href="Dangky.aspx" class="have">Bạn đã chưa có tài khoản? Đăng ký</a>
    </div>
</form>
</body>
</html>
