package utils;

import java.util.List;
import java.util.stream.Collectors;

/**
 * @author knight1527
 * Created with IntelliJ IDEA.
 * User: suse_QiHang
 * Date: 2021/06/30 15:07
 * Description:
 * Version: V1.0
 */

public class ResultSetProcessing {
    /*
     *搜索结果整理
     **/
    public static List<String[]> searchRel(final List<String[]> rel1, final List<String[]> rel2,
                                        final List<String[]> rel3){
        return rel1.stream()
                .filter(d -> rel2.stream()
                        .filter(t -> rel3.stream().anyMatch(s -> s[0].equals(t[0])))
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
}
