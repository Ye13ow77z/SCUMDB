package web.servlet.client;

import domain.Comment;
import domain.User;
import org.apache.log4j.Logger;
import service.CommentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/comment.do")
public class CommentServlet extends HttpServlet {
    static Logger logger = Logger.getLogger(CommentServlet.class);
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        String description = request.getParameter("description");
        String movieName = request.getParameter("movieName");
        User user = (User) request.getSession().getAttribute("user");
        
        // 检查用户是否登录
        if (user == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "请先登录");
            return;
        }
        
        // 检查参数是否为空
        if (description == null || description.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "评论内容不能为空");
            return;
        }
        
        if (movieName == null || movieName.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "电影名称不能为空");
            return;
        }

        logger.warn(description + " " + movieName);

        Comment comment = new Comment();
        comment.setMovieName(movieName);
        comment.setDescription(description);
        comment.setUserName(user.getUsername());

        CommentService service = new CommentService();
        try {
            service.addComment(comment);
            response.getWriter().write("ok");
        } catch (SQLException e) {
            e.printStackTrace();
            logger.error("添加评论失败：" + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "添加评论失败");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
