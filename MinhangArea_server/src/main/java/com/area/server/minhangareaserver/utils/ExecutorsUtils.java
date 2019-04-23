package com.area.server.minhangareaserver.utils;
/**
 * 	线程池
 * @author Administrator
 *
 */

import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.function.Function;
import java.util.function.Supplier;

public class ExecutorsUtils {
	
	private static  ExecutorService cachedThreadPool;

	static {
		int processors = Runtime.getRuntime().availableProcessors();
		cachedThreadPool = Executors.newFixedThreadPool(processors);
	}
	
	public static <V> Future<V> submit(Supplier<V> supplier){
		Callable<V> callable = new Callable<V>() {

			@Override
			public V call() throws Exception {
				return supplier.get();
			}
		};
		return cachedThreadPool.submit(callable);
	}
	
	public static <O> Future<O> submit(Function<O,O> supplier,O o){
		Callable<O> callable = new Callable<O>() {

			@Override
			public O call() throws Exception {
				return supplier.apply(o);
			}
		};
		return cachedThreadPool.submit(callable);
	}
}
