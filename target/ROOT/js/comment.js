(function ($) {
    $.fn.extend({
        insertContent: function (myValue, t) {
            var $t = $(this)[0];
            if (document.selection) {
                this.focus();
                var sel = document.selection.createRange();
                sel.text = myValue;
                this.focus();
                sel.moveStart('character', -l);
                var wee = sel.text.length;
                if (arguments.length == 2) {
                    var l = $t.value.length;
                    sel.moveEnd("character", wee + t);
                    t <= 0 ? sel.moveStart("character", wee - 2 * t - myValue.length) : sel.moveStart("character", wee - t - myValue.length);
                    sel.select();
                }
            } else if ($t.selectionStart || $t.selectionStart == '0') {
                var startPos = $t.selectionStart;
                var endPos = $t.selectionEnd;
                var scrollTop = $t.scrollTop;
                $t.value = $t.value.substring(0, startPos) + myValue + $t.value.substring(endPos, $t.value.length);
                this.focus();
                $t.selectionStart = startPos + myValue.length;
                $t.selectionEnd = startPos + myValue.length;
                $t.scrollTop = scrollTop;
                if (arguments.length == 2) {
                    $t.setSelectionRange(startPos - t, $t.selectionEnd + t);
                    this.focus();
                }
            } else {
                this.value += myValue;
                this.focus();
            }
        }
    })
})(jQuery);

$(document).ready(function () {
    // 图片插入功能
    $(".img-icon").click(function () {
        $(".cont-box .text").insertContent('<img src="请在这里输入图片地址" alt=""/>', -10);
    });
    
    // 评论字数统计
    $('.comment-textarea').on('input', function() {
        var maxLength = 250;
        var currentLength = $(this).val().length;
        var remaining = maxLength - currentLength;
        
        if (!$(this).next('.char-count').length) {
            $(this).after('<div class="char-count text-muted mt-2"></div>');
        }
        
        $(this).next('.char-count').text('还可以输入 ' + remaining + ' 个字符');
        
        if (remaining < 0) {
            $(this).next('.char-count').addClass('text-danger').removeClass('text-muted');
        } else {
            $(this).next('.char-count').addClass('text-muted').removeClass('text-danger');
        }
    });
    
    // 评论提交按钮状态
    $('.comment-textarea').on('input', function() {
        var content = $(this).val().trim();
        var submitBtn = $('.comment-submit-btn');
        
        if (content.length > 0 && content.length <= 250) {
            submitBtn.prop('disabled', false);
        } else {
            submitBtn.prop('disabled', true);
        }
    });
    
    // 表情选择器
    $('.emoji-btn').click(function(e) {
        e.preventDefault();
        var picker = $('.emoji-picker');
        
        if (picker.is(':visible')) {
            picker.hide();
        } else {
            picker.show();
        }
    });
    
    // 点击外部关闭表情选择器
    $(document).click(function(e) {
        if (!$(e.target).closest('.emoji-picker, .emoji-btn').length) {
            $('.emoji-picker').hide();
        }
    });
    
    // 表情点击事件
    $('.emoji-item').click(function() {
        var emoji = $(this).text();
        $('.comment-textarea').insertContent(emoji);
        $('.emoji-picker').hide();
    });
    
    // 评分功能
    $('.star').click(function() {
        var rating = $(this).data('rating');
        $('.star').removeClass('active').addClass('inactive');
        $('.star').each(function(index) {
            if (index < rating) {
                $(this).removeClass('inactive').addClass('active');
            }
        });
        $('#rating-value').val(rating);
    });
    
    // 评论点赞功能
    $('.comment-like').click(function() {
        var $this = $(this);
        var commentId = $this.data('comment-id');
        
        $.ajax({
            url: 'likeComment.do',
            method: 'POST',
            data: { commentId: commentId },
            success: function(response) {
                if (response.success) {
                    var likeCount = $this.find('.like-count');
                    var currentCount = parseInt(likeCount.text());
                    likeCount.text(currentCount + 1);
                    $this.addClass('liked');
                }
            }
        });
    });
    
    // 评论回复功能
    $('.comment-reply').click(function() {
        var commentId = $(this).data('comment-id');
        var username = $(this).data('username');
        
        $('.comment-textarea').val('@' + username + ' ');
        $('.comment-textarea').focus();
    });
    
    // 评论排序功能
    $('.comment-sort').change(function() {
        var sortBy = $(this).val();
        var movieName = $('#movieName').text();
        
        $.ajax({
            url: 'getComments.do',
            method: 'GET',
            data: { 
                movieName: movieName,
                sortBy: sortBy
            },
            success: function(response) {
                $('.comment-list').html(response);
            }
        });
    });
});

// 添加评论函数
function addComment() {
    var description = $("#description").val().trim();
    var movieName = $("#movieName").text();
    var rating = $('#rating-value').val() || 0;
    
    if (!description) {
        alert('请输入评论内容');
        return;
    }
    
    if (description.length > 250) {
        alert('评论内容不能超过250个字符');
        return;
    }
    
    // 显示加载状态
    var submitBtn = $('.comment-submit-btn');
    var originalText = submitBtn.text();
    submitBtn.prop('disabled', true).text('提交中...');
    
    $.ajax({
        url: "comment.do",
        data: {
            description: description,
            movieName: movieName,
            rating: rating
        },
        type: "POST",
        success: function (data) {
            if (data === "ok") {
                // 显示成功消息
                showMessage('评论提交成功！', 'success');
                // 清空输入框
                $("#description").val('');
                $('#rating-value').val('');
                $('.star').removeClass('active').addClass('inactive');
                // 刷新页面
                setTimeout(function() {
                    window.location.reload();
                }, 1500);
            } else {
                showMessage('评论提交失败，请重试', 'error');
            }
        },
        error: function (e) {
            console.log(e);
            showMessage('评论提交失败，请重试', 'error');
        },
        complete: function() {
            submitBtn.prop('disabled', false).text(originalText);
        }
    });
}

// 显示消息提示
function showMessage(message, type) {
    var alertClass = type === 'success' ? 'alert-success' : 'alert-danger';
    var alertHtml = '<div class="alert ' + alertClass + ' alert-dismissible fade show" role="alert">' +
                    message +
                    '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                    '<span aria-hidden="true">&times;</span>' +
                    '</button>' +
                    '</div>';
    
    $('.comment-section').prepend(alertHtml);
    
    // 3秒后自动消失
    setTimeout(function() {
        $('.alert').fadeOut();
    }, 3000);
}

// 评论分页功能
function changeCommentPage(pageNum) {
    var $c_info = $(".comment-item");
    var itemsPerPage = 4;
    var startIndex = (pageNum - 1) * itemsPerPage;
    var endIndex = startIndex + itemsPerPage;
    
    // 隐藏所有评论
    $c_info.addClass('d-none');
    
    // 显示当前页的评论
    $c_info.each(function(index) {
        if (index >= startIndex && index < endIndex) {
            $(this).removeClass('d-none');
        }
    });
    
    // 更新分页状态
    $("#controllPage li").removeClass('active');
    $("#controllPage li").eq(pageNum).addClass('active');
}

function lastCommentPage() {
    var $activePage = $("#controllPage li.active");
    var currentPage = $activePage.index();
    
    if (currentPage > 1) {
        changeCommentPage(currentPage - 1);
    }
}

function nextPageComment() {
    var $activePage = $("#controllPage li.active");
    var currentPage = $activePage.index();
    var totalPages = $("#controllPage li").length - 2; // 减去前后箭头
    
    if (currentPage < totalPages) {
        changeCommentPage(currentPage + 1);
    }
}