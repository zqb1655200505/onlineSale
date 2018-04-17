package com.zqb.main.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.zqb.main.dto.Page;
import com.zqb.main.utils.IdGen;

import javax.xml.bind.annotation.XmlTransient;

/**
 * Created by zqb on 2018/4/10.
 */
public class BasicEntity<T> {
    private String id;

    private boolean deleteFlag;

    /**
     * 当前实体分页对象
     */
    protected Page<T> page;
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void preInsert()
    {
        this.id= IdGen.uuid();
    }

    public boolean getDeleteFlag() {
        return deleteFlag;
    }

    public void setDeleteFlag(boolean deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    @JsonIgnore
    @XmlTransient
    public Page<T> getPage() {
        if (page == null){
            page = new Page<T>();
        }
        return page;
    }

    public Page<T> setPage(Page<T> page) {
        this.page = page;
        return page;
    }
}
