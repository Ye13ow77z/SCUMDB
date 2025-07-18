package utils;

import domain.Movie;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import web.servlet.client.LoginServlet;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: StoreDataUtil.java
 * @Description: 用于服务器启动时，向数据库中查询特定数据并保存的一个类
 * @author: zhuhaipeng
 * @version: V1.0
 * @Date: 2019年10月29日 下午9:53:56
 */
public class StoreDataUtil {
    private Map<String, List<Movie>> movies = new HashMap<String, List<Movie>>();
    static Logger logger = Logger.getLogger(LoginServlet.class);


    private StoreDataUtil() {
        logger.setLevel(Level.WARN);
    }

    private static class HolderClass {
        private final static StoreDataUtil instance = new StoreDataUtil();
    }

    public static StoreDataUtil getInstance() {
        return HolderClass.instance;
    }

    /**
     * @Description: 查询特定的电影数据
     */
    public Map<String, List<Movie>> getMovies() {
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        List<Movie> lists;
        // 定义要查询的种类
        String[] types = new String[]{"最新", "科幻", "喜剧", "动作", "剧情", "动画", "恐怖", "悬疑", "奇幻"};
        for (int i = 0; i < types.length; i++) {
            try {
                String sql;
                if (i > 0) {
                    sql = "SELECT MAX(id) as id, name, MAX(type) as type, MAX(years) as years, MAX(country) as country, MAX(director) as director, MAX(actor) as actor, MAX(des) as des, MAX(image) as image, MAX(url) as url, MAX(score) as score, MAX(scriptwriter) as scriptwriter, MAX(languages) as languages, MAX(length) as length FROM allmovies where name in (SELECT name FROM allmovies WHERE type=?) GROUP BY name HAVING (COUNT(type) <= 2) ORDER BY RAND() LIMIT 5";
                    lists = (List<Movie>) runner.query(sql, new BeanListHandler<Movie>(Movie.class), types[i]);
                } else {
                    sql = "SELECT * FROM `allmovies` where years=? limit 0,10";
                    lists = (List<Movie>) runner.query(sql, new BeanListHandler<Movie>(Movie.class), "2019");
                }
                logger.warn("list大小：" + lists.size());
                // 将对应种类的电影数据放到 map中保存
                this.movies.put(types[i], lists);
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

        }
        return this.movies;
    }
}