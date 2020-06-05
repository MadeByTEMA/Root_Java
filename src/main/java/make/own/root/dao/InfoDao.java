package make.own.root.dao;

import java.util.List;

import make.own.root.vo.Info;

public interface InfoDao {

  List<Info> findAll() throws Exception;

  Info findByNo(int no) throws Exception;

  List<Info> findByCategory(int category) throws Exception;
}
