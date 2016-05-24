package com.Singing.controller;

import org.python.core.PyFunction;
import org.python.core.PyObject;
import org.python.core.PyString;
import org.python.util.PythonInterpreter;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by fowafolo
 * Date: 16/5/24
 * Time: 10:59
 */
public class RecommendUtil {

    static public List<String> getTrackIds(int originUserId) {
        String newUserId = "";
        switch (originUserId) {
            case 1 :
                newUserId = "b80344d063b5ccb3212f76538f3d9e43d87dca9e";
            case 65 :
                newUserId = "85c1f87fea955d09b4bec2e36aee110927aedf9a";
            case 66 :
                newUserId = "bd4c6e843f00bd476847fb75c47b4fb430a06856";
            default:
                newUserId = "8937134734f869debcab8f23d77465b4caaa85df";
        }
        PythonInterpreter interpreter = new PythonInterpreter();

        interpreter.execfile("/Users/fowafolo/Desktop/recommend_file.py");
        PyFunction func = interpreter.get("read_in_memory", PyFunction.class);
        PyObject object = func.__call__(new PyString(newUserId));

        List<String> trackIdList = (List<String>) object.__tojava__(List.class);
        return trackIdList;
    }

    static public List<String> getRecommendByUserId(int originUserId) {
        List<String> ids = getTrackIds(originUserId);
        List<String> result = new ArrayList<String>();

//        if (ids != null) {
//            if (ids.size() != 0) {
//                result.add(ids.get(0));
//            }
//        }

        for (String item: ids) {
            result.add(item);
        }

        System.out.println(result);

        return result;
    }
}
