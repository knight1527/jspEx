# JSP练手作业项目总结
## 项目目录结构
```
- src
  -utils                          //java工具类包
    -ResultSetProcessing.java     //用于处理搜索结果集，去重（Stream流）
- web
  - CRUDquery                     //数据库操作相关文件
    - factorydb.jsp               //数据库连接池，减少代码冗余
    - Stubiz.jsp                  //Student实体增删改查方法
  - css                           //CSS样式文件夹
  - lib                           //semantic ui样式的依赖文件（实际上只用到了css在css文件夹里）
  - static                        //静态资源文件（图片等）
  - StuService                    //Student业务代码文件夹
    - delete.jsp                     
    - search.jsp                     //搜索处理
    - searchPlus.jsp                 //搜索结果页
    - showUpdatePlus.jsp            
    - successPlus.jsp                //主页
    - update.jsp
  - UserService                   //用户登录相关业务代码文件夹
    - logout.jsp
    - noUser.jsp
    - register.jsp
    - submit.jsp
    - userIn.jsp
    - wrongPsw.jsp
  - WEB-INF                       //配置文件及依赖文件文件夹
  - index.jsp                     //首页
```

## 相关问题思路及实现办法
##### 前端的样式由于使用的是semantic ui的样式就不再赘述，主要总结后端业务代码实现逻辑。还有很多可以优化的点，由于时间关系就先不做了。

### 数据库交互办法

  传统的jsp写法中给人一种错觉，每个只要和数据库有交互的jsp都要写注册连接的jdbc代码，需求稍微复杂一点，代码写起来毫无效率还容易产生bug。本着 `再复杂的业务也能用少量代码实现`的思想，查了一番资料。`javaweb整合开发与项目实战`的例子很棒。

通过一个factorydb.jsp写跟数据库的连接和关闭方法（简单工厂模式）其他页面引入即可，拿来即用，更改数据源也方便，只需要更改这一个jsp即可。不仅增加了健壮性，代码看起来也简洁易懂，不容易产生bug。

### 业务实现过程的增删改查
  同上，传统的思路每个增删改查或多个都对应一个页面的连接和关闭操作，sql语句处理都在各自单独的jsp里面，杂乱无章。

  思路同上：对于同一个业务类型可以只写一个增删改查的jsp，也就是吧所有的sql语句和执行操作封装在一个jsp中，其他处理jsp需要什么方法，引入即可，一张表对应一个jsp处理文件。如：对学生信息表的所有增删改查方法和sql语句都封装在Stubiz.jsp中，其他处理页面需要实现什么功能只需调用其中的一个或者多个方法即可。由于用户登录相关业务的处理，SQL语句少代码简单，就没封装方法了。

### 分页方法(避安全而不谈🙃)

  传统方法是：通过数据查询的SQL语句层面来做文章的，通过limit截断处理，也就是说每点击一个页面链接就得执行一次数据库查询操作，这种方法效率未免有点低了。

  思路：先将整体查询结果存放在集合之中，分页只需提取集合中指定索引段（当然首选ArrayList）的数据即可，这样就把分页操作搬到代码层面上来了，当然这需要session或者其他处理办法让这个结果集合的生存周期持续到下一次更新，由于这种办法非常适合搜索结果的分页，所以就在搜索结果页面用了，在全表查询分页那儿还是传统方法。

### 多条件搜索处理

于搜索表单提供了多个输入选择，所以提交后的表单有可能全空或者存在有空值的input，有两个input为空都还好，可以一个模糊查询就能找到结果，但是有两个以上不为空的时候就要注意多条件都要满足。

思路：同上，还是将功能实现放到代码层面上来。对每一个input单独执行一个查询sql，当然要对每一个input匹配一个SQL语句（当然这都封装在Stubiz的方法中的）每一个查询返回一个结果集合，搜索目标的获得就是不为空的集合的交集（全空当然就没有结果）。对于集合交集的求法，我选择用stream流来做，传统的集合处理代码看起来复杂而且效率低，stream流结合lambda表达式代码量少逻辑清晰，而且stream的流水线式处理方式使集合处理效率极高。

由于没写student实体对象，所以项目中的Student实体是以字符串数组的形式存储的
```java
//由于有多种情况所以需要对方法重载：
/*
     *搜索结果整理
     **/
    public static List<String[]> searchRel(final List<String[]> rel1,final List<String[]> rel2,final List<String[]> rel3){
              						
        return rel1.stream()
                .filter(d -> rel2.stream()
                        .filter(t -> rel3.stream()
                        			.anyMatch(s -> s[0].equals(t[0]))
                        )
                        .anyMatch(t -> t[0].equals(d[0]))
                )
                .collect(Collectors.toList());
    }
    public static List<String[]> searchRel(final List<String[]> rel1,final List<String[]> rel2){
    
        return rel1.stream()
                .filter(d -> rel2.stream()
                        .anyMatch(t -> t[0].equals(d[0]))
                )
                .collect(Collectors.toList());
    }
```

