<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">
    
    <xsl:output method="xml" omit-xml-declaration="no"/>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="chapter/@name">
        <xsl:attribute name="id">
            <xsl:apply-templates/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="p">
        <para>
            <xsl:apply-templates/>
        </para>
    </xsl:template>
    
    <xsl:template match="ol">
        <orderedlist>
            <xsl:apply-templates/>
        </orderedlist>
    </xsl:template>
    
    <xsl:template match="li">
        <listitem>
            <xsl:apply-templates/>
        </listitem>
    </xsl:template>
    
    <xsl:template match="ul">
        <itemizedlist>
            <xsl:apply-templates/>
        </itemizedlist>
    </xsl:template>
    
    <xsl:template match="codeblock">
        <programlisting>
             <xsl:apply-templates select="@*|node()"/>
        </programlisting>
    </xsl:template>
    
    <xsl:template match="codeblock/@language">
        <xsl:attribute name="language">
            <xsl:apply-templates/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="index"/>
    
    <xsl:template match="span">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="annotation[@type='tool']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="annotation[@type='concept']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="annotation[@type='language']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="annotation[@type='structure']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="annotation[@type='algorithm']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="annotation[@type='code']">
        <code>
            <xsl:apply-templates/>
        </code>
    </xsl:template>
    
    <xsl:template match="annotation[@type='italic']">
        <emphasis>
            <xsl:apply-templates/>
        </emphasis>
    </xsl:template>

    <xsl:template match="annotation[@type='title']">
        <citetitle>
            <xsl:apply-templates/>
        </citetitle>
    </xsl:template>
    
    <xsl:template match="citation[@type='citation']">
        <xsl:apply-templates/>        
        <xsl:text>[</xsl:text>
        <xsl:value-of select="@value"/>
        <xsl:text>]</xsl:text>
    </xsl:template>
    
    <xsl:template match="blockquote/citation[@type='citation']">   
        <attribution>
        <xsl:value-of select="@value"/>
        </attribution>
    </xsl:template>
    
    <xsl:template match="citation[@type='nameref']">
        <olink targetptr="{@value}">
            <xsl:apply-templates/>
        </olink>
    </xsl:template>
    
    <xsl:template match="insert[@type='image']">
        <mediaobject>
            <xsl:if test="@id">
                <xsl:attribute name="id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <imageobject>
                <imagedata fileref="{@item}"/>
            </imageobject>
        </mediaobject>
    </xsl:template>
    
    <xsl:template match="insert[@type='id']">
        <xref linkend="{@item}"/>
    </xsl:template>
    
    
    
    <xsl:template match="figure/insert[@type='image']">
            <imageobject>
                <imagedata fileref="{@item}"/>
            </imageobject>
    </xsl:template>
    
    <xsl:template match="figure[insert[@type='image']]">
        <mediaobject>
            <xsl:if test="@id">
                <xsl:attribute name="id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </mediaobject>
    </xsl:template>
    
    
    <xsl:template match="figure[title]">
        <figure>
                <xsl:apply-templates select="title"/>
            <mediaobject>
                <xsl:if test="@id">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="*[not(self::title)]"/> 
            </mediaobject>
        </figure>
    </xsl:template>
    
    <xsl:template match="ll">
        <variablelist>
            <xsl:apply-templates/>
        </variablelist>
    </xsl:template>
    
    
    <xsl:template match="ll/li">
        <varlistentry>
            <xsl:apply-templates/>
        </varlistentry>
    </xsl:template>
    
    <xsl:template match="ll/li/label">
        <term>
            <xsl:apply-templates/>
        </term>
    </xsl:template>
    
    <xsl:template match="ll/li/p">
        <listitem>
            <para>
                <xsl:apply-templates/>
            </para>
        </listitem>
    </xsl:template>
  
</xsl:stylesheet>

