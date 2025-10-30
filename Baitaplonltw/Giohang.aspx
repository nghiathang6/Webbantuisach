<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Giohang.aspx.cs" Inherits="Baitaplonltw.Giohang" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Giỏ Hàng</title>
    <link href="cssgiohang.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper">
            <div class="header-container">
                <a href="TrangChu.aspx">
                    <img src="icon/logo2.png" alt="logo" width="60px" style="margin-left:30px" />
                </a>
                <asp:TextBox ID="txtTuKhoa" runat="server" CssClass="o-tim-kiem" Placeholder="Tìm kiếm..." onkeyup="searchProducts(this.value)" AutoComplete="off" />
                <div id="searchResults" style="position:absolute; display:none; background:white; border:1px solid #ccc; max-height:300px; overflow-y:auto; width:300px; z-index:1000;"></div>
                <div class="hang-text">
                    <span class="clickable-text" onclick="window.location.href='Tuideocheo.aspx'">Túi đeo chéo</span>
                    <span class="clickable-text" onclick="window.location.href='Tuideovai.aspx'">Túi đeo vai</span>
                    <span class="clickable-text" onclick="window.location.href='Tuixachtay.aspx'">Túi xách tay</span>
                    <span class="clickable-text" onclick="window.location.href='Donhang.aspx'">Đơn hàng</span>
                </div>
                <a href="Giohang.aspx">
                    <img src="icon/cart.png" alt="cart" width="40px" style="margin-left:40px;margin-top:10px" />
                </a>

                <div class="user-menu">
                    <img src="icon/user.png" alt="User" class="user-icon" onclick="toggleMenu()" />
                    <div id="dropdown" class="dropdown-menu">
                        <a href="Dangnhap.aspx">Đăng nhập</a>
                        <a href="Dangky.aspx">Đăng ký</a>
                    </div>
                </div>
                <asp:Label ID="lblChao" runat="server" CssClass="xinchao" />
            </div>

            <div class="cart-container">
                <h2>Giỏ hàng của bạn</h2>
                <asp:Repeater ID="rptGioHang" runat="server" OnItemCommand="rptGioHang_ItemCommand">
    <ItemTemplate>
        <div class="cart-item">
            <img src='<%# Eval("Anh") %>' class="item-img" />
            <div class="item-info">
                <h3><%# Eval("Ten") %></h3>
                <p>Giá: <%# Eval("Gia", "{0:N0}") %> đ</p>
                <p>Số lượng: <%# Eval("SoLuong") %></p>
                <p>Thành tiền: <%# Eval("ThanhTien", "{0:N0}") %> đ</p>

                <!-- Nút xóa sản phẩm -->
                <asp:Button ID="btnXoa" runat="server" Text="Xóa"
                    CommandName="Xoa" CommandArgument='<%# Eval("ID") %>' CssClass="btn-delete" />
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>
                <asp:Label ID="lblTongTien" runat="server" CssClass="total-price" />
                <br />
                <asp:Button ID="btnThanhToan" runat="server" Text="Thanh Toán" CssClass="btn-pay" OnClick="btnThanhToan_Click" />
            </div>
        </div>
    </form>
    <script>
    let timeout = null;

    function searchProducts(keyword) {
        clearTimeout(timeout);
        const resultsDiv = document.getElementById("searchResults");

        if (keyword.trim() === "") {
            resultsDiv.innerHTML = "";
            resultsDiv.style.display = "none"; // Ẩn khi không có keyword
            return;
        }

        timeout = setTimeout(() => {
            fetch("TrangChu.aspx/SearchProducts", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json; charset=utf-8"
                },
                body: JSON.stringify({ keyword: keyword })
            })
                .then(res => res.json())
                .then(data => {
                    const products = data.d;
                    let html = "";
                    if (products && products.length > 0) {
                        products.forEach(item => {
                            html += `<div style="padding:5px; border-bottom:1px solid #ddd; display:flex; align-items:center; cursor:pointer;" onclick="goToDetail('${item.ID}')">
                            <img src="${item.Anh}" alt="${item.Ten}" style="width:50px; height:50px; object-fit:cover; margin-right:10px;" />
                            <span>${item.Ten}</span>
                        </div>`;
                        });
                        resultsDiv.innerHTML = html;
                        resultsDiv.style.display = "block"; // Hiện khi có kết quả
                    } else {
                        resultsDiv.innerHTML = "<div style='padding:10px;'>Không tìm thấy sản phẩm</div>";
                        resultsDiv.style.display = "block"; // Vẫn hiện khi không có sản phẩm
                    }
                })
                .catch(err => {
                    console.error(err);
                    resultsDiv.style.display = "none";
                });
        }, 300);
    }

    function goToDetail(id) {
        window.location.href = `Chitiet.aspx?id=${id}`;
    }

    // Ẩn kết quả tìm kiếm khi click ra ngoài
    document.addEventListener("click", function (e) {
        var searchDiv = document.getElementById("searchResults");
        var txtBox = document.getElementById("<%= txtTuKhoa.ClientID %>");
    if (!searchDiv.contains(e.target) && e.target !== txtBox) {
        searchDiv.innerHTML = "";
        searchDiv.style.display = "none";
    }
});
</script>
</body>
</html>
