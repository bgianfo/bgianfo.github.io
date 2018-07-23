---
layout: post
title: "C++14 A Fancy New Language."
excerpt: "We attempt to start learning the  elixir language."
tags: ["software", "c++", "c++14", "programming languages"]
comments: true
---

<!-- The Sources -->
[std-draft]: http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2014/n4296.pdf
[rvalue-ex]: http://thbecker.net/articles/rvalue_references/section_01.html

# Intro

## Flavor

{% highlight cpp linenos %}
enum class FlavorType
{
    Vanilla,
    Chocolate,
    RaspBerry,
    BlackBerry,
}
{% endhighlight %}

## Cones

{% highlight cpp linenos %}
enum class ConeType
{
    Waffle,
    Sugar,
    None,
}
{% endhighlight %}


## Ice Cream

{% highlight cpp linenos %}

// Provide a representation of IceCream's.
//
class IceCream final
{
public:
    // Represent the flavor of the ice cream.
    //
    const FlavorType Flavor;

    // Represent the type of cone.
    //
    const ConeType Cone;

protected:

    // Disable constructors for the factory.
    //
    IceCream() = delete;
    IceCream(const IceCreamFactory&) = delete;

    // Grant the factroy friend access.
    //
    friend class IceCreamFactory;

    // Constructor for representing an ice cream falvor.
    //
    IceCream(const FlavorType flavorType, const ConeType coneType)
        : Flavor(flavorType), Cone(coneType)
    {
    }

    // Don't allow anyone to destroy most objects.
    //
    ~IceCream() { }
}
{% endhighlight %}

## Ice Cream Factory

{% highlight cpp linenos %}
// Provide a factory for caching types of ice cream's.
//
class IceCreamFactory final
{
    // Disable constructors for the factory.
    //
    IceCreamFactory() = delete;
    IceCreamFactory(const IceCreamFactory&) = delete;
    IceCreamFactory& IceCreamFactory=(const IceCreamFactory&) = delete;


    // Create a caching factory method, who will cache any new
    // object type that it hasn't seen before.
    //
    static IceCream* Create(const FlavorType flavorType, const ConeType coneType)
    {
        auto key = std::make_pair(flavorType, coneType);

        if (m_Collection.count(key) == 0)
        {
            m_Collection[key] = new IceCream(flavorType, coneType);
        }

        return m_Collection[key];
    }

    // Map of types of IceCream to there there concreate allocated types.
    //
    static std::map<std::pair<FlavorType, ConeType>, IceCream*> m_Collection;
}
{% endhighlight %}

# Resources
- [C++15 Working Draft][std-draft]
- [RValue References Explained][rvalue-ex]

