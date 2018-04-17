package com.zqb.main.utils;



/**
 * Created by Yann on 2017/8/12.
 */
public class CheckSQLStrUtils {

    public static boolean sql_inj(String str)
    {
        //String inj_str = "'| and | exec | insert | select | delete | update | count | %|% | chr | mid | master | truncate | char | declare | or | -- | <script";
        String inj_str = " and | exec | insert | select | delete | update | count | %|% | chr | mid | master | truncate | char | declare | or | -- |<script";

        String inj_stra[] = inj_str.split("|");
        for (int i=0 ; i < inj_stra.length ; i++)
        {
            if (str.indexOf(inj_stra[i]) >= 0)
            {
                return true;
            }
        }
        return false;
    }
}
