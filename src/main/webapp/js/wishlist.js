// Wishlist functionality
function toggleWishlist(productId, button) {
    const icon = $(button).find('i');
    const isInWishlist = icon.hasClass('fas');
    
    $.ajax({
        url: 'WishlistServlet',
        type: 'POST',
        data: {
            action: isInWishlist ? 'remove' : 'add',
            productId: productId
        },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                // Toggle icon
                if (isInWishlist) {
                    icon.removeClass('fas').addClass('far');
                    $(button).removeClass('text-danger').addClass('text-muted');
                } else {
                    icon.removeClass('far').addClass('fas');
                    $(button).removeClass('text-muted').addClass('text-danger');
                }
                
                // Update wishlist count in header
                if (response.count !== undefined) {
                    updateWishlistCount(response.count);
                }
                
                // Show toast
                showToast(response.message, 'success');
            } else {
                showToast(response.message, 'error');
            }
        },
        error: function(xhr) {
            if (xhr.status === 401 || xhr.responseText.includes('đăng nhập')) {
                showToast('Vui lòng đăng nhập để sử dụng tính năng này', 'error');
                setTimeout(function() {
                    window.location.href = 'LoginServlet';
                }, 1500);
            } else {
                showToast('Có lỗi xảy ra', 'error');
            }
        }
    });
}

function updateWishlistCount(count) {
    const badge = $('.wishlist-count-badge');
    if (badge.length > 0) {
        badge.text(count);
        if (count > 0) {
            badge.show();
        } else {
            badge.hide();
        }
    }
}

function showToast(message, type) {
    // Remove existing toasts
    $('.toast').remove();
    
    const iconClass = type === 'success' ? 'fa-check-circle text-success' : 'fa-times-circle text-danger';
    const toastHtml = `
        <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
            <div class="toast show" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="toast-header">
                    <i class="fas ${iconClass} me-2"></i>
                    <strong class="me-auto">Thông báo</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
                </div>
                <div class="toast-body">${message}</div>
            </div>
        </div>
    `;
    
    $('body').append(toastHtml);
    
    setTimeout(function() {
        $('.toast').fadeOut(300, function() {
            $(this).parent().remove();
        });
    }, 3000);
}
