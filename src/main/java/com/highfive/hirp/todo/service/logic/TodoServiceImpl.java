package com.highfive.hirp.todo.service.logic;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.highfive.hirp.todo.service.TodoService;
import com.highfive.hirp.todo.store.TodoStore;

@Service
public class TodoServiceImpl implements TodoService {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private TodoStore tStore;
}