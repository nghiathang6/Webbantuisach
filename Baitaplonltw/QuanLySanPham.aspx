<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuanLySanPham.aspx.cs" Inherits="Baitaplonltw.QuanLySanPham" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>QuanTriSanPham</title>
    <link href="StyleQuanTri.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Quản lý sản phẩm</h1>

            <asp:Label runat="server" AssociatedControlID="txtTenBanh" Text="Tên túi xách:" CssClass="form-group" />
            <asp:TextBox ID="txtTenBanh" runat="server" CssClass="form-group" />

            <asp:Label runat="server" AssociatedControlID="txtGia" Text="Giá:" CssClass="form-group" />
            <asp:TextBox ID="txtGia" runat="server" TextMode="Number" CssClass="form-group" />

            <asp:Label runat="server" AssociatedControlID="txtMoTa" Text="Mô tả:" CssClass="form-group" />
            <asp:TextBox ID="txtMoTa" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-group" />

            <asp:Label runat="server" AssociatedControlID="txtAnh" Text="Link ảnh:" CssClass="form-group" />
            <asp:TextBox ID="txtAnh" runat="server" CssClass="form-group" Placeholder="Nhập link ảnh..." />

            <asp:Label runat="server" AssociatedControlID="ddlLoai" Text="Loại túi:" CssClass="form-group" />
            <asp:DropDownList ID="ddlLoai" runat="server" CssClass="form-group">
                <asp:ListItem Text="Túi đeo chéo" Value="TuiDeoCheo" />
                <asp:ListItem Text="Túi đeo vai" Value="TuiDeoVai" />
                <asp:ListItem Text="Túi sách tay" Value="TuiSachTay" />
                <asp:ListItem Text="Túi tote" Value="TuiTote" />

            </asp:DropDownList>

            <asp:Button ID="btnThem" runat="server" Text="Thêm" CssClass="btn btn-them" OnClick="btnThem_Click" />
            <asp:Button ID="btnSua" runat="server" Text="Sửa" CssClass="btn btn-sua" OnClick="btnSua_Click" />
            <asp:Button ID="btnXoa" runat="server" Text="Xóa" CssClass="btn btn-xoa" OnClick="btnXoa_Click" />

            <asp:GridView ID="gvSanPham" runat="server" AutoGenerateColumns="False" OnSelectedIndexChanged="gvSanPham_SelectedIndexChanged">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" SelectText="Chọn" HeaderText="Chọn" />
                    <asp:BoundField DataField="ID" HeaderText="Mã SP" />
                    <asp:TemplateField HeaderText="Ảnh">
                        <ItemTemplate>
                            <img src='<%# Eval("Anh") %>' alt="Ảnh bánh" style="max-height:60px;" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Ten" HeaderText="Tên túi" />
                    <asp:BoundField DataField="Gia" HeaderText="Giá" DataFormatString="{0:N0} đ" />
                    <asp:BoundField DataField="MoTa" HeaderText="Mô tả" />
                    <asp:BoundField DataField="Loai" HeaderText="Loại túi" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
