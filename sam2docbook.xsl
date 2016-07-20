<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:db="http://docbook.org/ns/docbook" 
    xmlns:xi="http://www.w3.org/2001/XInclude" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs"
    version="1.0">
    
    <xsl:output method="xml" omit-xml-declaration="no"/>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:processing-instruction name="xml-model">
            <xsl:text>href="http://www.oasis-open.org/docbook/xml/5.0/rng/docbook.rng" schematypens="http://relaxng.org/ns/structure/1.0"
</xsl:text>
         </xsl:processing-instruction>
        <xsl:processing-instruction name="xml-model">
            <xsl:text>href="http://www.oasis-open.org/docbook/xml/5.0/rng/docbook.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"
</xsl:text>
         </xsl:processing-instruction>

        <xsl:text disable-output-escaping="yes">
<![CDATA[
<!DOCTYPE book []]>
</xsl:text>        
        <xsl:for-each select="//string">
            <xsl:text disable-output-escaping="yes"><![CDATA[<!ENTITY ]]></xsl:text>
            <xsl:value-of select="@name"/>
            <xsl:text> "</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text disable-output-escaping="yes">">
</xsl:text>  
        </xsl:for-each>
        <xsl:text disable-output-escaping="yes">]>
</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="string"/>
    
    <xsl:template match="by"/>
    
    <xsl:template match="book">
        <db:book  version="5.0">
            <xsl:apply-templates/>
        </db:book>
    </xsl:template>
    
    <xsl:template match="title">
        <db:title>
            <xsl:apply-templates/>
        </db:title>
    </xsl:template>
    
    <xsl:template match="subtitle">
        <db:subtitle>
            <xsl:apply-templates/>
        </db:subtitle>
    </xsl:template>
    
    <xsl:template match="part">
        <db:part>
            <xsl:apply-templates/>
        </db:part>
    </xsl:template>
    
    <xsl:template match="index">
        <db:index>
            <xsl:apply-templates/>
        </db:index>
    </xsl:template>
    
    <xsl:template match="appendix">
        <db:appendix>
            <xsl:apply-templates/>
        </db:appendix>
    </xsl:template>
    
    <xsl:template match="@conditions">
        <xsl:attribute name="condition">
            <xsl:apply-templates/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@name">
        <xsl:attribute name="xml:id">
            <xsl:apply-templates/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="insert[@type='string']">
        <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
        <xsl:value-of select="@item"/>
        <xsl:text>;</xsl:text>
    </xsl:template>
    
    <xsl:template match="insert[@type='sam']">
        <xsl:element name="xi:include">
            <xsl:attribute name="href">
                <xsl:value-of select="substring-before(@item,'.sam')"/>
                <xsl:text>.xml</xsl:text>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="insert[@type='xml']">
        <xsl:element name="xi:include">
            <xsl:attribute name="href">
                <xsl:value-of select="@item"/>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="/chapter">
        <db:chapter 
           version="5.0"> 
            <xsl:apply-templates/>
        </db:chapter>
    </xsl:template>

    <xsl:template match="book/chapter | part/chapter">
        <db:chapter>
            <db:title>
                <xsl:apply-templates/>
            </db:title>
            <db:para>
                Not available yet.
            </db:para>
        </db:chapter>
    </xsl:template>
    
    
    
    <xsl:template match="chapter/@name">
        <xsl:attribute name="xml:id">
            <xsl:apply-templates/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="p">
        <db:para>
            <xsl:apply-templates/>
        </db:para>
    </xsl:template>
    
    <xsl:template match="ol">
        <db:orderedlist>
            <xsl:apply-templates/>
        </db:orderedlist>
    </xsl:template>
    
    <xsl:template match="li">
        <db:listitem>
            <xsl:apply-templates/>
        </db:listitem>
    </xsl:template>
    
    <xsl:template match="ul">
        <db:itemizedlist>
            <xsl:apply-templates/>
        </db:itemizedlist>
    </xsl:template>
    
    <xsl:template match="codeblock">
        <db:programlisting>
             <xsl:apply-templates select="@*|node()"/>
        </db:programlisting>
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
        <db:code>
            <xsl:apply-templates/>
        </db:code>
    </xsl:template>
    
    <xsl:template match="annotation[@type='italic']">
        <db:emphasis>
            <xsl:apply-templates/>
        </db:emphasis>
    </xsl:template>

    <xsl:template match="annotation[@type='title']">
        <db:citetitle>
            <xsl:apply-templates/>
        </db:citetitle>
    </xsl:template>
    
    <xsl:template match="citation[@type='citation']">
        <xsl:apply-templates/>        
        <xsl:text>[</xsl:text>
        <xsl:value-of select="@value"/>
        <xsl:text>]</xsl:text>
    </xsl:template>
    
    <xsl:template match="blockquote">
        <db:blockquote>
            <xsl:apply-templates/>
        </db:blockquote>
    </xsl:template>
    
    <xsl:template match="blockquote/citation[@type='citation']">   
        <db:attribution>
            <xsl:value-of select="@value"/>
        </db:attribution>
    </xsl:template>
    
    <xsl:template match="citation[@type='nameref']">
        <db:olink targetptr="{@value}">
            <xsl:apply-templates/>
        </db:olink>
    </xsl:template>
    
    <xsl:template match="insert[@type='image']">
        <db:mediaobject>
            <xsl:if test="@id">
                <xsl:attribute name="id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <db:imageobject>
                <db:imagedata fileref="{@item}"/>
            </db:imageobject>
        </db:mediaobject>
    </xsl:template>
    
    <xsl:template match="insert[@type='id']">
        <db:xref linkend="{@item}"/>
    </xsl:template>
    
    
    
    <xsl:template match="figure/insert[@type='image']">
        <db:imageobject>
            <db:imagedata fileref="{@item}"/>
            </db:imageobject>
    </xsl:template>
    
    <xsl:template match="figure[insert[@type='image']]">
        <db:mediaobject>
            <xsl:if test="@id">
                <xsl:attribute name="id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </db:mediaobject>
    </xsl:template>
    
    
    <xsl:template match="figure[title]">
        <db:figure>
                <xsl:apply-templates select="title"/>
            <db:mediaobject>
                <xsl:if test="@id">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="*[not(self::title)]"/> 
            </db:mediaobject>
        </db:figure>
    </xsl:template>
    
    <xsl:template match="ll">
        <db:variablelist>
            <xsl:apply-templates/>
        </db:variablelist>
    </xsl:template>
    
    
    <xsl:template match="ll/li">
        <db:varlistentry>
            <xsl:apply-templates/>
        </db:varlistentry>
    </xsl:template>
    
    <xsl:template match="ll/li/label">
        <db:term>
            <xsl:apply-templates/>
        </db:term>
    </xsl:template>
    
    <xsl:template match="ll/li/p">
        <db:listitem>
            <db:para>
                <xsl:apply-templates/>
            </db:para>
        </db:listitem>
    </xsl:template>
  
</xsl:stylesheet>

