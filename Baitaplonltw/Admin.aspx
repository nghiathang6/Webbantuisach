<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Baitaplonltw.Admin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trang quản trị</title>
    <link href="StyleSheet2.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="admin-container">
            <h2>Chào mừng Admin!</h2>
            <p>Chọn chức năng bên dưới:</p>
            <asp:Button ID="btnQuanLySanPham" runat="server" Text="Quản lý sản phẩm" OnClick="btnQuanLySanPham_Click" CssClass="admin-btn" />
            <asp:Button ID="btnQuanLyDonHang" runat="server" Text="Quản lý đơn hàng" OnClick="btnQuanLyDonHang_Click" CssClass="admin-btn" />
        </div>
    </form>
</body>
</html>
