<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:db="http://docbook.org/ns/docbook" 
    xmlns:xi="http://www.w3.org/2001/XInclude" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:strings="http://exslt.org/strings"
    exclude-result-prefixes="xs"
    version="1.0">
    
    <xsl:output method="xml" omit-xml-declaration="no"/>
    
    <xsl:variable name="default-content-width" select="5.25"/>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
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
            <xsl:if test="@name">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@name"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </db:part>
    </xsl:template>
    
    <xsl:template match="book/index">
        <db:index>
            <xsl:apply-templates/>
        </db:index>
    </xsl:template>
    
    <xsl:template match="chapter/index"/>
    
    <xsl:template match="appendix">
        <db:appendix>
            <xsl:apply-templates select="@* | *"/>
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
        <xsl:variable name="item" select="@item"/>
        <xsl:value-of select="//string[@name=$item]"/>
    </xsl:template>
    
    <xsl:template match="inline-insert[@type='string']">
        <xsl:variable name="item" select="@item"/>
        <xsl:value-of select="//string[@name=$item]"/>
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
            <xsl:if test="@name">
              <xsl:attribute name="xml:id">
                  <xsl:value-of select="@name"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </db:chapter>
    </xsl:template>

    <xsl:template match="book/chapter | part/chapter">
        <db:chapter>
            <xsl:choose>
                <xsl:when test="title">
                    <xsl:apply-templates select="title"/>
                    <db:para>
                        Not available yet.
                    </db:para>  
                    <xsl:apply-templates  select="title/following-sibling::*"/>
                </xsl:when>
                <xsl:otherwise>
                    <db:title>
                        <xsl:apply-templates/>
                    </db:title>
                   <db:para>
                       Not available yet.
                   </db:para>  
                </xsl:otherwise>
            </xsl:choose>
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
    
    <xsl:template match="formatted-code">
        <db:programlisting>
            <xsl:apply-templates select="@*|node()"/>
        </db:programlisting>
    </xsl:template>
    
    <xsl:template match="formatted-code/line">
        <xsl:apply-templates/>
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
 
    <xsl:template match="phrase">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="annotations"/>
    
    <xsl:template match="annotation[@type='standard']">
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
        <db:code>
            <xsl:apply-templates/>
        </db:code>
    </xsl:template>
    
    <xsl:template match="annotation[@type='algorithm']">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="annotation[@type='system']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="annotation[@type='role']">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="annotation[@type='method']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="annotation[@type='attribute']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="annotation[@type='FIXME']">
        <db:emphasis role="bold">FIXME!</db:emphasis><xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="annotation[@type='format']">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="annotation[@type='person']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="annotation[@type='citetitle']">
        <db:citetitle>
            <xsl:apply-templates/>
        </db:citetitle>
    </xsl:template>
    
    <xsl:template match="annotation[@type='url']">
        <db:link xlink:href="{.}">
            <xsl:apply-templates/>
        </db:link>        
    </xsl:template>
    
    <xsl:template match="bibliography"></xsl:template>
    
    
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
    
    <xsl:template match="annotation[@type='bold']">
        <db:emphasis role="bold">
            <xsl:apply-templates/>
        </db:emphasis>
    </xsl:template>
    
    <xsl:template match="annotation[@type='guibutton']">
        <db:guibutton>
            <xsl:apply-templates/>
        </db:guibutton>
    </xsl:template>
    
    <xsl:template match="annotation[@type='title']">
        <db:citetitle>
            <xsl:apply-templates/>
        </db:citetitle>
    </xsl:template>
    
    <xsl:template match="citation[@type='citation']">
        <xsl:apply-templates/>    
        <xsl:choose>
            <xsl:when test="ancestor::footnote">
                <xsl:text>[</xsl:text>
                <xsl:value-of select="@value"/>
                <xsl:text>]</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <db:footnote>
                    <db:para>
                        <xsl:value-of select="@value"/>
                    </db:para>
                </db:footnote>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="citation[@type='idref']">
        <xsl:variable name="idref" select="@value"/>
        <xsl:choose>
            <xsl:when test="//footnote[@id=$idref]">
                <xsl:apply-templates select="//footnote[@id=$idref]" mode="resolve-footnote"/>
            </xsl:when>
            <xsl:when test="//figure[@id=$idref]">
                <db:xref linkend="{$idref}"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message>
                    <xsl:text>No element found with id </xsl:text>
                    <xsl:value-of select="$idref"/>
                </xsl:message>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>

    
    <xsl:template match="footnote"/>
    <xsl:template match="footnote" mode="resolve-footnote">
        <db:footnote>
            <xsl:apply-templates/>
        </db:footnote>
    </xsl:template>
    
    <xsl:template match="blockquote">
        <db:blockquote>
            <xsl:apply-templates/>
        </db:blockquote>
    </xsl:template>
    
    <xsl:template match="blockquote//section">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="blockquote//section/title">
        <db:bridgehead renderas="sect4">
            <xsl:apply-templates/>
        </db:bridgehead>
    </xsl:template>
    
    <xsl:template match="blockquote/citation[@type='citation']">   
        <db:attribution>
            <xsl:value-of select="@value"/>
        </db:attribution>
    </xsl:template>
    
    <xsl:template match="blockquote/citation[@type='nameref']">
        <xsl:variable name="nameref" select="@value"/>
        <db:attribution>
            <xsl:value-of select="$nameref"/>
        </db:attribution>
    </xsl:template>
    
    <xsl:template match="citation[@type='nameref']" priority="-.1">
        <db:xref linkend="{@value}"/>
    </xsl:template>

    <xsl:template match="phrase/citation[@type='nameref']">
        <xsl:apply-templates/>
        <xsl:text> (</xsl:text>
        <db:xref linkend="{@value}"/>
        <xsl:text>)</xsl:text>
    </xsl:template>
    
    <xsl:template match="insert[@type='image']">
        <!-- This template assumes that the relative path to the image in the 
             output file is the same as that of the source file. In other 
             words it assumes that the source directory and the XML ouput directory
             are children of the same parent. 
             
             It does not currently support or detect absolute paths.
        -->
        <db:mediaobject>
            <xsl:if test="@id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="create-imageobject"/>
        </db:mediaobject>
    </xsl:template>
    
    <xsl:template name="create-imageobject">
        <xsl:choose>
            <xsl:when test="substring(@item, string-length(@item) - 3) = '.xml'">
                <xsl:variable name="item-file" select="strings:tokenize(@item, '/\')[last()]"/>
                <xsl:variable name="item-path" select="substring(@item, 1, string-length(@item)-string-length($item-file))"/>
                <xsl:variable name="imagedata" select="document(@item)"/>
                <db:imageobject condition="fo">
                    <db:imagedata>
                        <xsl:attribute name="fileref"><xsl:value-of select="concat($item-path,$imagedata/image/fo/href)"/></xsl:attribute>
                        <xsl:if test="$imagedata/image/fo/contentwidth != ''">
                            <xsl:attribute name="contentwidth"><xsl:value-of select="$imagedata/image/fo/contentwidth"/></xsl:attribute>      
                        </xsl:if>
                        <xsl:if test="$imagedata/image/fo/align != ''">
                            <xsl:attribute name="align"><xsl:value-of select="$imagedata/image/fo/align"/></xsl:attribute>     
                        </xsl:if>
                    </db:imagedata> 
                </db:imageobject>
                <db:imageobject condition="epub">
                    <db:imagedata>
                        <xsl:attribute name="fileref"><xsl:value-of select="concat($item-path,$imagedata/image/epub/href)"/></xsl:attribute>
                        <xsl:if test="$imagedata/image/epub/contentwidth != ''">
                            <xsl:attribute name="contentwidth"><xsl:value-of select="$imagedata/image/epub/contentwidth"/></xsl:attribute>      
                        </xsl:if>
                        <xsl:if test="$imagedata/image/epub/align != ''">
                            <xsl:attribute name="align"><xsl:value-of select="$imagedata/image/epub/align"/></xsl:attribute>     
                        </xsl:if>
                    </db:imagedata> 
                </db:imageobject>
                <xsl:if test="$imagedata/image/alt">
                    <db:textobject>
                        <xsl:apply-templates select="$imagedata/image/alt/*"/>
                    </db:textobject>
                </xsl:if>
                
            </xsl:when>
            <xsl:otherwise>
                <db:imageobject>
                    <db:imagedata fileref="{@item}" contentwidth="{$default-content-width}" align="left"/>
                </db:imageobject>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="inline-insert[@type='image']">
        <!-- This template assumes that the relative path to the image in the 
             output file is the same as that of the source file. In other 
             words it assumes that the source directory and the XML ouput directory
             are children of the same parent. 
             
             It does not currently support or detect absolute paths.
        -->
        <db:inlinemediaobject>
            <xsl:if test="@id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="substring(@item, string-length(@item) - 3) = '.xml'">
                    <xsl:variable name="item-file" select="strings:tokenize(@item, '/\')[last()]"/>
                    <xsl:variable name="item-path" select="substring(@item, 1, string-length(@item)-string-length($item-file))"/>
                    <xsl:variable name="imagedata" select="document(@item)"/>
                    <db:imageobject condition="epub">
                        <db:imagedata>
                            <xsl:attribute name="fileref"><xsl:value-of select="concat($item-path,$imagedata/image/epub/href)"/></xsl:attribute>
                            <xsl:if test="$imagedata/image/epub/contentwidth != ''">
                                <xsl:attribute name="contentwidth"><xsl:value-of select="$imagedata/image/epub/contentwidth"/></xsl:attribute>      
                            </xsl:if>
                            <xsl:if test="$imagedata/image/epub/align != ''">
                                <xsl:attribute name="align"><xsl:value-of select="$imagedata/image/epub/align"/></xsl:attribute>     
                            </xsl:if>
                        </db:imagedata> 
                    </db:imageobject>
                    <db:imageobject condition="fo">
                        <db:imagedata>
                            <xsl:attribute name="fileref"><xsl:value-of select="concat($item-path,$imagedata/image/fo/href)"/></xsl:attribute>
                            <xsl:if test="$imagedata/image/fo/contentwidth != ''">
                                <xsl:attribute name="contentwidth"><xsl:value-of select="$imagedata/image/fo/contentwidth"/></xsl:attribute>      
                            </xsl:if>
                            <xsl:if test="$imagedata/image/fo/align != ''">
                                <xsl:attribute name="align"><xsl:value-of select="$imagedata/image/fo/align"/></xsl:attribute>     
                            </xsl:if>
                        </db:imagedata> 
                    </db:imageobject>
                    <xsl:if test="$imagedata/image/alt">
                        <db:textobject>
                            <xsl:apply-templates select="$imagedata/image/alt/*"/>
                        </db:textobject>
                    </xsl:if>
                    
                </xsl:when>
                <xsl:otherwise>
                    <db:imageobject>
                        <db:imagedata fileref="{@item}" contentwidth="{$default-content-width}" align="left"/>
                    </db:imageobject>
                </xsl:otherwise>
            </xsl:choose>
        </db:inlinemediaobject>
    </xsl:template>
    
    <xsl:template match="insert[@type='id']">
        <db:xref linkend="{@item}"/>
    </xsl:template>
    
    <xsl:template match="inline-insert[@type='id']">
        <db:xref linkend="{@item}"/>
    </xsl:template>
    
    
    

    <xsl:template match="figure/insert[@type='image']">
        <xsl:call-template name="create-imageobject"/>
    </xsl:template>

<!--    <xsl:template match="figure[insert[@type='image']]">
        <db:mediaobject>
            <xsl:if test="@id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </db:mediaobject>
    </xsl:template>
    
-->    
    <xsl:template match="figure[title]">
        <db:figure>
            <xsl:if test="@id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@name">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@name"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="title"/>
            <xsl:choose>
                <xsl:when test="insert[@type='image']">
                    <db:mediaobject>
                        <xsl:apply-templates select="*[not(self::title)]"/> 
                    </db:mediaobject>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="*[not(self::title)]"/>                   
                </xsl:otherwise>
            </xsl:choose>
        </db:figure>
    </xsl:template>
 
    <xsl:template match="figure[not(title)]">
        <db:informalfigure>
            <xsl:if test="@id">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@name">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@name"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="insert[@type='image']">
                    <db:mediaobject>
                        <xsl:apply-templates/> 
                    </db:mediaobject>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>                   
                </xsl:otherwise>
            </xsl:choose>
        </db:informalfigure>
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
    
    <xsl:template match="caption">
        <db:caption>
            <xsl:apply-templates/>
        </db:caption>
    </xsl:template>

    <xsl:template match="section">
        <db:section>
            <xsl:apply-templates/>
        </db:section>
    </xsl:template>

    <!-- Section from the book file that is just text -->
    <xsl:template match="book/chapter/section/text()[normalize-space() != '']">
        <db:title>
            <xsl:value-of select="."/>
        </db:title>
        <db:para>
            Not available yet.
        </db:para>
    </xsl:template>
    
    
    <xsl:template match="grid">
        <db:informaltable>
            <db:tbody>
                <xsl:apply-templates/>
            </db:tbody>
        </db:informaltable>
    </xsl:template>

    <xsl:template match="row">
        <db:tr>
            <xsl:apply-templates/>
        </db:tr>
    </xsl:template>

    <xsl:template match="cell">
        <db:td>
            <xsl:apply-templates/>
        </db:td>

    </xsl:template>

</xsl:stylesheet>

