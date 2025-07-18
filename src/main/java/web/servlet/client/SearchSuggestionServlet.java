package web.servlet.client;

import com.alibaba.fastjson.JSON;
import domain.Movie;
import service.SearchService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

/**
 * @ClassName: SearchSuggestionServlet.java
 * @Description: 处理实时搜索建议
 * @author: zhuhaipeng
 * @version: V1.0
 * @Date: 2019年10月30日 下午3:15:08
 */
@WebServlet(urlPatterns = "/searchSuggestion.do")
public class SearchSuggestionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("application/json;charset=utf-8");

        String searchCondition = request.getParameter("search");
        
        if (searchCondition == null || searchCondition.trim().isEmpty()) {
            response.getWriter().write("[]");
            return;
        }

        SearchService service = new SearchService();

        try {
            List<Movie> movies = service.search(searchCondition);
            // 按名称去重，只保留前5个不同名称的电影
            List<Movie> uniqueMovies = new ArrayList<>();
            Set<String> nameSet = new HashSet<>();
            for (Movie m : movies) {
                if (!nameSet.contains(m.getName())) {
                    uniqueMovies.add(m);
                    nameSet.add(m.getName());
                }
                if (uniqueMovies.size() >= 5) break;
            }
            String jsonResult = JSON.toJSONString(uniqueMovies);
            response.getWriter().write(jsonResult);
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("[]");
        }
    }
}