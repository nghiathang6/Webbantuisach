<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tuideovai.aspx.cs" Inherits="Baitaplonltw.Tuideovai" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="trangchu.css" rel="stylesheet" />
</head>
<body>
        <form id="form1" runat="server">
        <div class="wrapper">
   <div class="header-container">
       <a href="TrangChu.aspx">
           <img src="icon/logo2.png" alt="logo" width="60px" style="margin-left:30px"/>
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
           <img src="icon/cart.png" alt="cart" width="40px" style="margin-left:40px;margin-top:10px"/>
       </a>

       <div class="user-menu">
               <img src="icon/user.png" alt="User" class="user-icon" onclick="toggleMenu()" />
               <div id="dropdown" class="dropdown-menu">
                   <a href="Dangnhap.aspx">Đăng nhập</a>
                   <a href="Dangky.aspx">Đăng ký</a>
               </div>
           </div>
           <asp:Label ID="lblChao" runat="server" class="xinchao" Text=""/>
       </div>
            <div style="text-align: center; margin-top: 30px;">
                <img src="/icon/banner3.jpg" alt="banner3" width="1400px" />
            </div>

            <p class="trangchu-cater">Trang chủ   |   Túi đeo vai</p>

            <select id="ddlPriceRange" onchange="filterByPrice()">
                <option value="">-- Chọn khoảng giá --</option>
                <option value="0-500000">Dưới 500,000 đ</option>
                <option value="500000-1000000">500,000 - 1,000,000 đ</option>
                <option value="1000000-2000000">1,000,000 - 2,000,000 đ</option>
            </select>

             <div class="product-container">
    <asp:Repeater ID="rptbontdv" runat="server">
        <ItemTemplate>
            <div class="product-card">
                <a href='<%# "Chitiet.aspx?id=" + Eval("ID") %>'>
                    <img src='<%# Eval("Anh") %>' alt="Ảnh" class="product-img" />
                </a>
                <div class="product-name"><%# Eval("Ten") %></div>
                <div class="product-price"><%# Eval("Gia", "{0:N0}") %> đ</div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
 </div>
             <div class="product-container">
    <asp:Repeater ID="rptbontdv2" runat="server">
        <ItemTemplate>
            <div class="product-card">
                <a href='<%# "Chitiet.aspx?id=" + Eval("ID") %>'>
                    <img src='<%# Eval("Anh") %>' alt="Ảnh" class="product-img" />
                </a>
                <div class="product-name"><%# Eval("Ten") %></div>
                <div class="product-price"><%# Eval("Gia", "{0:N0}") %> đ</div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
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
     <script>
         function filterByPrice() {
             var priceRange = document.getElementById("ddlPriceRange").value;
             if (!priceRange) return;

             fetch('Tuixachtay.aspx/FilterProductsByPrice', {
                 method: 'POST',
                 headers: { 'Content-Type': 'application/json; charset=utf-8' },
                 body: JSON.stringify({ priceRange: priceRange })
             })
                 .then(res => res.json())
                 .then(data => {
                     var products = data.d;
                     var container = document.querySelector('.product-container');
                     container.innerHTML = '';

                     if (products.length === 0) {
                         container.innerHTML = '<p>Không tìm thấy sản phẩm phù hợp.</p>';
                         return;
                     }

                     products.forEach(p => {
                         container.innerHTML += `
     <div class="product-card">
         <a href="Chitiet.aspx?id=${p.ID}">
             <img src="${p.Anh}" alt="${p.Ten}" class="product-img" />
         </a>
         <div class="product-name">${p.Ten}</div>
         <div class="product-price">${p.Gia.toLocaleString('vi-VN')} đ</div>
     </div>`;
                     });
                 })
                 .catch(err => console.error(err));
         }

     </script>
</body>
</html>
