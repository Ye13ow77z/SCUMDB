package dao;

import domain.ClickTime;
import domain.Movie;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import utils.DataSourceUtils;

import java.sql.SQLException;
import java.util.List;

/**
 * @ClassName: ClickTimeDao.java
 * @Description: 处理与clicknumber表的数据交互
 * @author: zhuhaipeng
 * @version: V1.0
 * @Date: 2019年10月31日 下午10:21:15
 */
public class ClickTimeDao {
    /**
     * @param movieName 被更新的电影名
     * @throws SQLException
     * @Description: 更新对应电影的点击次数
     */
    public void updateRecord(String movieName) throws SQLException {
        String sql = "UPDATE clicknumber SET number=(SELECT time FROM"
                + "(SELECT number as time FROM clicknumber WHERE movieName=?)"
                + "as a)+1 where movieName=?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        runner.update(sql, movieName, movieName);
    }

    /**
     * @param movieName 电影名
     * @throws SQLException
     * @Description: 查询对应电影名的点击次数
     */
    public int getMovieClickTime(String movieName) throws SQLException {
        String sql = "select number from clicknumber where movieName=?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanHandler<ClickTime>(ClickTime.class), movieName).getNumber();
    }

    /**
     * @return
     * @throws SQLException
     * @Description: 查询数据库中点击次数最多的4部电影
     */
    public List<Movie> getHotMovies() throws SQLException {
        String sql = "SELECT DISTINCT a.* FROM allmovies a " +
                "INNER JOIN clicknumber c ON a.name = c.movieName " +
                "ORDER BY c.number DESC LIMIT 4";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanListHandler<Movie>(Movie.class));
    }

    /**
     * 功查询数据库中点击次数最多的3部电影
     *
     * @return java.util.List<domain.Movie>
     * @author GGBOY
     * @date 2019/11/26
     */
    public List<Movie> getThreeHotMovies() throws SQLException {
        String sql = "SELECT DISTINCT a.* FROM allmovies a " +
                "INNER JOIN clicknumber c ON a.name = c.movieName " +
                "ORDER BY c.number DESC LIMIT 3";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanListHandler<Movie>(Movie.class));
    }
}
