package com.Singing.controller;

import org.python.core.PyFunction;
import org.python.core.PyObject;
import org.python.core.PyString;
import org.python.util.PythonInterpreter;

import java.util.List;

/**
 * Created by fowafolo
 * Date: 16/5/24
 * Time: 10:59
 */
public class RecommendUtil {

    static public List<String> getTrackIds(int originUserId) {
        String newUserId = RecommendUtil.transforToStrUserId(originUserId);
        PythonInterpreter interpreter = new PythonInterpreter();

        interpreter.execfile("/Users/fowafolo/Desktop/recommend_file.py");
        PyFunction func = interpreter.get("read_in_memory", PyFunction.class);
        PyObject object = func.__call__(new PyString(newUserId));

        List<String> trackIdList = (List<String>) object.__tojava__(List.class);
        return trackIdList;
    }

    static public String transforToStrUserId(int originUserId) {
        String newUserId = "";
        switch (originUserId) {
            case 1 :
                newUserId = "b80344d063b5ccb3212f76538f3d9e43d87dca9e";
                break;
            case 65 :
                newUserId = "85c1f87fea955d09b4bec2e36aee110927aedf9a";
                break;
            case 66 :
                newUserId = "bd4c6e843f00bd476847fb75c47b4fb430a06856";
                break;
            default:
                newUserId = "8937134734f869debcab8f23d77465b4caaa85df";
                break;
        }
        return newUserId;
    }
}