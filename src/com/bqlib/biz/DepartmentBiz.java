/**
 * 院系业务类
 */

package com.bqlib.biz;

import java.sql.Connection;
import java.util.List;

import com.bqlib.dao.DepartmentDao;
import com.bqlib.model.Department;
import com.bqlib.util.DbUtil;

public class DepartmentBiz {
    
    private DepartmentDao departmentDao = new DepartmentDao();
    
    /**
     * 获取表中所有的院系
     * @return
     * @throws Exception
     */
    public List<Department> listDeparment() throws Exception {
        Connection conn = DbUtil.getConn();
        List<Department> departmentList = departmentDao.listDeparment();
        DbUtil.close();
        return departmentList;
    }
    
    /**
     * 添加院系
     * @param department
     * @return
     * @throws Exception
     */
    public int addDepartment(Department department) throws Exception {
        Connection conn = DbUtil.getConn();
        int num = departmentDao.addDepartment(department);
        DbUtil.close();
        return num;
    }
    
    /**
     * 修改院系
     * @param department
     * @return
     * @throws Exception
     */
    public int updateDepartment(Department department) throws Exception {
        Connection conn = DbUtil.getConn();
        int num = departmentDao.updateDepartment(department);
        DbUtil.close();
        return num;
    }
    
    /**
     * 删除院系
     * @param dId
     * @return
     * @throws Exception
     */
    public int deleteDepartment(String dId) throws Exception {
        Connection conn = DbUtil.getConn();
        int num = departmentDao.deleteDepartment(dId);
        DbUtil.close();
        return num;
    }
    
    /**
     * 根据id查找院系
     * @param dId
     * @return
     * @throws Exception
     */
    public Department getDeparmentById(String dId) throws Exception {
        Connection conn = DbUtil.getConn();
        Department department = departmentDao.getDeparmentById(dId);
        DbUtil.close();
        return department;
    }
    
    /**
     * 统计院系的个数
     * @return
     * @throws Exception
     */
    public int countDepartment() throws Exception {
        Connection conn = DbUtil.getConn();
        int num = departmentDao.countDepartment();
        DbUtil.close();
        return num;
    }
    
    /**
     * 获取部分院系列表（用于分页）
     * @param start
     * @param size
     * @return
     * @throws Exception
     */
    public List<Department> listDepartmentLimit(Integer start, Integer size) throws Exception { 
        Connection conn = DbUtil.getConn();
        List<Department> departmentList = departmentDao.listDepartmentLimit(start, size);
        DbUtil.close();
        return departmentList;
    }
}
